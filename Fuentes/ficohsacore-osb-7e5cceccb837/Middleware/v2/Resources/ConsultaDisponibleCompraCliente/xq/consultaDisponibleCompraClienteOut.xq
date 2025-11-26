(:: pragma bea:global-element-parameter parameter="$consultaDisponibleCompraClienteResponse" element="ns0:ConsultaDisponibleCompraClienteResponse" location="../../../BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDisponibleCompraClienteResponse" location="../xsd/consultaDisponibleCompraClienteTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDisponibleCompraClienteTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDisponibleCompraCliente/xq/consultaDisponibleCompraClienteOut/";

declare function xf:consultaDisponibleCompraClienteOut($consultaDisponibleCompraClienteResponse as element(ns0:ConsultaDisponibleCompraClienteResponse))
    as element(ns1:consultaDisponibleCompraClienteResponse) {
        <ns1:consultaDisponibleCompraClienteResponse>
            <PROFILE>{ data($consultaDisponibleCompraClienteResponse/FICOSELLCUSTAVAILABEFXWSType[1]/gFICOSELLCUSTAVAILABEFXWSDetailType/mFICOSELLCUSTAVAILABEFXWSDetailType[1]/ProfileNumber) }</PROFILE>
            <PROFILE_NUMBER>{ data($consultaDisponibleCompraClienteResponse/FICOSELLCUSTAVAILABEFXWSType[1]/gFICOSELLCUSTAVAILABEFXWSDetailType/mFICOSELLCUSTAVAILABEFXWSDetailType[1]/ProfileNumber) }</PROFILE_NUMBER>
            <NAME>{ data($consultaDisponibleCompraClienteResponse/FICOSELLCUSTAVAILABEFXWSType[1]/gFICOSELLCUSTAVAILABEFXWSDetailType/mFICOSELLCUSTAVAILABEFXWSDetailType[1]/CustomerName) }</NAME>
            <AVAILABLE>{ data($consultaDisponibleCompraClienteResponse/FICOSELLCUSTAVAILABEFXWSType[1]/gFICOSELLCUSTAVAILABEFXWSDetailType/mFICOSELLCUSTAVAILABEFXWSDetailType[1]/AvailableAmt[1]) }</AVAILABLE>
            <SPECIAL_AVAILABLE>{ data($consultaDisponibleCompraClienteResponse/FICOSELLCUSTAVAILABEFXWSType[1]/gFICOSELLCUSTAVAILABEFXWSDetailType/mFICOSELLCUSTAVAILABEFXWSDetailType[1]/LRSPLCUST) }</SPECIAL_AVAILABLE>
        </ns1:consultaDisponibleCompraClienteResponse>
};

declare variable $consultaDisponibleCompraClienteResponse as element(ns0:ConsultaDisponibleCompraClienteResponse) external;

xf:consultaDisponibleCompraClienteOut($consultaDisponibleCompraClienteResponse)
