(:: pragma bea:global-element-parameter parameter="$actualizaDisponibleMonedaFCYResponse" element="ns0:ActualizaDisponibleMonedaFCYResponse" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)
(:: pragma bea:global-element-return element="ns1:actualizaDisponibleVentaMonedaExtranjeraResponse" location="../xsd/actualizaDisponibleVentaMonedaExtranjeraTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaDisponibleVentaMonedaExtranjeraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xq/actualizaDisponibleVentaMonedaExtranjeraOut/";

declare function xf:actualizaDisponibleVentaMonedaExtranjeraOut($actualizaDisponibleMonedaFCYResponse as element(ns0:ActualizaDisponibleMonedaFCYResponse))
    as element(ns1:actualizaDisponibleVentaMonedaExtranjeraResponse) {
        <ns1:actualizaDisponibleVentaMonedaExtranjeraResponse>
            {
                for $successIndicator in $actualizaDisponibleMonedaFCYResponse/Status/successIndicator
                return
                    <SUCCESS_FLAG>{ data($successIndicator) }</SUCCESS_FLAG>
            }
        </ns1:actualizaDisponibleVentaMonedaExtranjeraResponse>
};

declare variable $actualizaDisponibleMonedaFCYResponse as element(ns0:ActualizaDisponibleMonedaFCYResponse) external;

xf:actualizaDisponibleVentaMonedaExtranjeraOut($actualizaDisponibleMonedaFCYResponse)