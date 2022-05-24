/* Copyright Airship and Contributors */
package ti.airship.events

interface Event {
    val data: Map<String, Any>
    val name: String
}