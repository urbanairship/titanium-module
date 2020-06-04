/* Copyright Airship and Contributors */

package ti.airship.events;

import androidx.annotation.NonNull;

import org.appcelerator.kroll.KrollProxy;

import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.WeakHashMap;

/**
 * Event emitter that handles queuing and resending events if there are no active
 * listeners for the event type.
 */
public class EventEmitter {

    private static EventEmitter shared = new EventEmitter();
    private final Map<String, List<Event>> pendingEvents = new HashMap<>();
    private final Map<KrollProxy, Listeners> proxyMap = new WeakHashMap<>();

    private EventEmitter() {
    }

    public static EventEmitter shared() {
        return shared;
    }

    public synchronized void fireEvent(@NonNull Event event) {
        boolean success = false;
        for (Listeners listeners : proxyMap.values()) {
            if (listeners.fireEvent(event)) {
                success = true;
            }
        }

        if (!success) {
            List<Event> pending = pendingEvents.get(event.getName());
            if (pending == null) {
                pending = new ArrayList<>();
                pendingEvents.put(event.getName(), pending);
            }

            pending.add(event);
        }
    }

    public synchronized void addListeners(String eventName, int count, KrollProxy proxy) {
        Listeners listeners = proxyMap.get(proxy);

        if (listeners == null) {
            listeners = new Listeners(proxy);
            proxyMap.put(proxy, listeners);
        }

        listeners.addEventListeners(eventName, count);

        List<Event> pending = pendingEvents.remove(eventName);
        if (pending != null) {
            for (Event event : pending) {
                fireEvent(event);
            }
        }
    }

    public synchronized void removeListeners(String eventName, int count, KrollProxy proxy) {
        Listeners listeners = proxyMap.get(proxy);

        if (listeners != null) {
            listeners.removeEventListeners(eventName, count);
        }
    }

    private class Listeners {

        private Map<String, Integer> listenerCounts = new HashMap<>();
        private final WeakReference<KrollProxy> proxyWeakReference;

        Listeners(@NonNull KrollProxy proxy) {
            proxyWeakReference = new WeakReference<>(proxy);
        }

        void removeEventListeners(@NonNull String eventName, int count) {
            listenerCounts.put(eventName, Math.min(0, getListenerCount(eventName) - count));
        }

        void addEventListeners(@NonNull String eventName, int count) {
            listenerCounts.put(eventName, getListenerCount(eventName) + count);
        }

        boolean fireEvent(@NonNull Event event) {
            if (getListenerCount(event.getName()) == 0) {
                return false;
            }

            KrollProxy proxy = proxyWeakReference.get();
            if (proxy == null) {
                return false;
            }

            return proxy.fireEvent(event.getName(), new HashMap<>(event.getData()));
        }

        private int getListenerCount(@NonNull String eventName) {
            Integer count = listenerCounts.get(eventName);
            if (count == null) {
                return 0;
            }
            return count;
        }

    }
}
