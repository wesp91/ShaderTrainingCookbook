using UnityEngine;

[ExecuteInEditMode]
public class SetRadiusProperties : MonoBehaviour
{
    [SerializeField] private Material _radiusMaterial;
    [SerializeField] private float _radius = 1;
    [SerializeField] private float _radiusWidth = 1;
    [SerializeField] private Color _color = Color.white;


    void Start()
    {
        
    }

    void Update()
    {
        if(_radiusMaterial != null)
        {
            _radiusMaterial.SetVector("_Center", transform.position);
            _radiusMaterial.SetFloat("_Radius", _radius);
            _radiusMaterial.SetFloat("_RadiusWidth", _radiusWidth);
            _radiusMaterial.SetColor("_RadiusColor", _color);
        }
    }
}
