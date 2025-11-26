(:: pragma bea:global-element-parameter parameter="$consultamontodisponiblevtadolarResponse" element="ns0:consultamontodisponiblevtadolarResponse" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDisponibleVentaMonedaExtranjeraResponse" location="../xsd/consultaDisponibleVentaMonedaExtranjeraTypes.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xq/consultaDisponibleVentaMonedaExtranjeraOut/";

declare function xf:consultaDisponibleVentaMonedaExtranjeraOut($consultamontodisponiblevtadolarResponse as element(ns0:consultamontodisponiblevtadolarResponse))
    as element(ns1:consultaDisponibleVentaMonedaExtranjeraResponse) {
        <ns1:consultaDisponibleVentaMonedaExtranjeraResponse>
            {
                let $result :=
                    for $AvailableAmt in $consultamontodisponiblevtadolarResponse/FICOESELLTABLEENTRIESFXWSType[1]/gFICOESELLTABLEENTRIESFXWSDetailType/mFICOESELLTABLEENTRIESFXWSDetailType[1]/AvailableAmt
                    return
                        <AMOUNT_AVAILABLE>{ data($AvailableAmt) }</AMOUNT_AVAILABLE>
                return
                    $result[1]
            }
        </ns1:consultaDisponibleVentaMonedaExtranjeraResponse>
};

declare variable $consultamontodisponiblevtadolarResponse as element(ns0:consultamontodisponiblevtadolarResponse) external;

xf:consultaDisponibleVentaMonedaExtranjeraOut($consultamontodisponiblevtadolarResponse)