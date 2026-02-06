xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ingresaBeneficio" element="ns0:ingresaProductoBeneficio" location="../xsd/gestionesProductoBeneficioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ingresaProductoBeneficio" location="../xsd/gestionesProductoBeneficioTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesProductoBeneficioTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesProductoBeneficio/xq/gestionesProductoBeneficioPAFIn/";

declare function xf:gestionesProductoBeneficioPAFIn($ingresaBeneficio as element(ns0:ingresaProductoBeneficio))
    as element(ns0:ingresaProductoBeneficio) {
        <ns0:ingresaProductoBeneficio>
            <PRODUCT>
                <TYPE>{ data($ingresaBeneficio/PRODUCT/TYPE) }</TYPE>
                <VALUE>{ data($ingresaBeneficio/PRODUCT/VALUE) }</VALUE>
            </PRODUCT>
            <BENEFIT>
                <TYPE>{ data($ingresaBeneficio/BENEFIT/TYPE) }</TYPE>
                <VALUE>{ data($ingresaBeneficio/BENEFIT/VALUE) }</VALUE>
            </BENEFIT>
            <ADDITIONAL_INFO>
                {
                    for $info in $ingresaBeneficio/ADDITIONAL_INFO/INFO
                    return
                        <INFO>  
                             <NAME>{ data($info/NAME ) }</NAME>
                             <VALUE>{ data($info/VALUE) }</VALUE>
                        </INFO>
                }
            </ADDITIONAL_INFO>
        </ns0:ingresaProductoBeneficio>
};

declare variable $ingresaBeneficio as element(ns0:ingresaProductoBeneficio) external;

xf:gestionesProductoBeneficioPAFIn($ingresaBeneficio)