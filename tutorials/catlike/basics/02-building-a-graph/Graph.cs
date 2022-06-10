// From Catlike Coding Unity Basics 2: Building a Graph
//      https://catlikecoding.com/unity/tutorials/basics/building-a-graph/

using UnityEngine;

public class Graph : MonoBehaviour
{
    [SerializeField]
    Transform pointPrefab;

    // Range attribute makes the Unity inspector enforce a range to a configurable value.
    // Unity will make a slider for all ranged fields.
    [SerializeField, Range(10, 100)]
    int resolution = 10;

    [SerializeField, Range(0.01f, 0.2f)]
    float pointScale = 0.04f;

    Transform[] points;

    void Awake()
    {
        float domain = 2f;
        float step = domain / resolution;

        Vector3 position = Vector3.zero;
        Vector3 scale = Vector3.one * pointScale;

        points = new Transform[resolution];

        // ++i evaluates immediately, whereas i++ evaluates last in the expression.
        for (int i = 0; i < points.Length; i++)
        {
            // Instantiate clones a Unity object
            // If given a prefab, it will instantiate an instance of it into the current scene
            Transform point = points[i] = Instantiate(pointPrefab);

            position.x = (i + 0.5f) * step - (domain / 2f); // populate the domain with points, centered at x=0
            point.localPosition = position;
            point.localScale = scale;

            // Set point transform's parent to the graph's transform.
            // worldPositionStays = false : Don't retain the child's world pos/rot/scale.
            //                              Relocate it relative to new parent.
            point.SetParent(transform, false);
        }
    }

    void Update()
    {
        float time = Time.time;
        for (int i = 0; i < points.Length; i++)
        {
            Transform point = points[i];

            // Since localPosition is a property, we can't update it directly
            // Need to get, modify, then set the value
            Vector3 position = point.localPosition;
            position.y = Mathf.Sin(Mathf.PI * (position.x + time));
            point.localPosition = position;
        }
    }
}
