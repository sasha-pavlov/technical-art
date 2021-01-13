// TangentSpaceVisualizer visualizes the normals, tangents, and binormals of each vertex in the
// GameComponent's mesh.
// CatlikeCoding authored this tutorial script: https://catlikecoding.com/unity/tutorials/rendering/part-6/

using UnityEngine;

public class TangentSpaceVisualizer : MonoBehaviour
{
    // Configure length and offset of lines in the visualization
    [SerializeField]
    float offset = 0.01f, scale = 0.1f;

    // Each time gizmos are drawn, grab the mesh and visualize its tangent space
    private void OnDrawGizmos() {
        MeshFilter filter = GetComponent<MeshFilter>();
        if (filter) {
            Mesh mesh = filter.sharedMesh;
            if (mesh) {
                ShowTangentSpace(mesh);
            }
        }
    }

    // Transform vertex positions and normals to world space,
    // so that they match the geometry of the scene. Then use them
    // to draw lines.
    private void ShowTangentSpace (Mesh mesh) {
        Vector3[] vertices = mesh.vertices;
        Vector3[] normals = mesh.normals;
        
        // The 4th component of a tangent (T) is a sign (w = +/-1) that ensures
        // the binormal/bitangent (B = w(N x T)) points forwards rather than backwards.
        // This is important because meshes are often mirrored for bilateral modeling,
        // in which case the w component of the mirrored tangents is 1, whereas for
        // the usual tangent vector w = -1.
        Vector4[] tangents = mesh.tangents;

        for (int i = 0; i < vertices.Length; i++) {
            ShowTangentSpace(
                transform.TransformPoint(vertices[i]),
                transform.TransformDirection(normals[i]),
                transform.TransformDirection(tangents[i]),
                tangents[i].w
            );
        }
    }

    // Use the vertex positions and normals to draw green lines corresponding to normals,
    // red lines corresponding to tangents, and blue lines corresponding to binormals

    private void ShowTangentSpace(Vector3 vertex, Vector3 normal, Vector3 tangent, float binormalSign) {
        vertex += normal * offset;
        Vector3 binormal = Vector3.Cross(normal, tangent) * binormalSign;

        Gizmos.color = Color.green;
        Gizmos.DrawLine(vertex, vertex + normal * scale);
        Gizmos.color = Color.red;
        Gizmos.DrawLine(vertex, vertex + tangent * scale);
        Gizmos.color = Color.blue;
        Gizmos.DrawLine(vertex, vertex + binormal * scale);
    }
}
