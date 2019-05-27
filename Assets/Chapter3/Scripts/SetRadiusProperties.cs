using UnityEngine;

[ExecuteInEditMode]
public class SetRadiusProperties : MonoBehaviour
{
    [SerializeField] private Material _radiusMaterial;
    [SerializeField] private float _radius;
    [SerializeField] private Color _color = Color.white;


    void Update()
    {
        if(_radiusMaterial != null)
        {
            _radiusMaterial.SetVector("_Center", transform.position);
            _radiusMaterial.SetFloat("_Radius", _radius);
            _radiusMaterial.SetColor("_RadiusColor", _color);
        }
    }
}
