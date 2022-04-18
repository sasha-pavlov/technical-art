// From Catlike Coding Unity Basics 1: Game Objects and Scripts
//      https://catlikecoding.com/unity/tutorials/basics/game-objects-and-scripts/

// TODO Complex Numbers practice: rewrite in radians instead of Euler degrees

using System;
using UnityEngine;

// Clock rotates hours/minutes/seconds arms according to the system time
// All custom Unity components must extend Unity's MonoBehaviour type
public class Clock : MonoBehaviour {
    const float hoursToDegrees = -30f, minutesToDegrees = -6f, secondsToDegrees = -6f;

    // SerializeField attribute informs Unity that the field should be included
    // in the saved scene data.
    // Allows us to associate an object (or more likely an object's component,
    // ex. Transform) in the scene with this field.
    [SerializeField]
    Transform hoursPivot, minutesPivot, secondsPivot;

    void Update () {
        // Use var keyboard when the type is explicitly mentioned in the declaration
        TimeSpan time = DateTime.Now.TimeOfDay;

        // localRotation is a property: a method that wraps a field
        hoursPivot.localRotation =
            Quaternion.Euler(0f, 0f, (float)time.TotalHours * hoursToDegrees);
        minutesPivot.localRotation =
            Quaternion.Euler(0f, 0f, (float)time.TotalMinutes * minutesToDegrees);
        secondsPivot.localRotation =
            Quaternion.Euler(0f, 0f, (float)time.TotalSeconds * secondsToDegrees);
    }
}
