/* Copyright Airship and Contributors */
package ti.airship.events

import androidx.arch.core.util.Function
import java.util.ArrayList

/**
 * Event emitter that handles queuing and resending events if there are no active
 * listeners for the event type.
 */
object EventManager {
    private val pendingEvents = mutableListOf<Event>()
    private val lock = Any()
    private var dispatcher: Function<Event, Boolean>? = null

    fun setDispatcher(dispatcher: Function<Event, Boolean>) {
        synchronized(lock) {
            this.dispatcher = dispatcher
            dispatchPending()
        }
    }

    fun dispatch(event: Event) {
        synchronized(lock) {
            if (dispatcher == null || !dispatcher!!.apply(event)) {
                pendingEvents.add(event)
            }
        }
    }

    fun onListenerAdded() {
        dispatchPending()
    }

    private fun dispatchPending() {
        synchronized(lock) {
            val copy: List<Event> = ArrayList(
                pendingEvents
            )
            pendingEvents.clear()
            for (event in copy) {
                dispatch(event)
            }
        }
    }
}