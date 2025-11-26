(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader" element="ns1:AutenticacionRequestHeader" location="../../../xsds/General/Autenticacion.xsd" ::)
(:: pragma bea:schema-type-parameter parameter="$status" type="ns0:Status" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EliminacionpagorecaudorefTT" location="../../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRecaudo/Piloto/eliminacionPagoRecaudoReferenciadoTTIn/";

declare function xf:eliminacionPagoRecaudoReferenciadoTTIn($autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader),
    $status as element())
    as element(ns0:EliminacionpagorecaudorefTT) {
        <ns0:EliminacionpagorecaudorefTT>
            <WebRequestCommon>
                <userName>{ data($autenticacionRequestHeader/UserName) }</userName>
                <password>{ data($autenticacionRequestHeader/Password) }</password>
            </WebRequestCommon>
            <TELLERREFCOLLCASHWSCOPYType>
                {
                    for $transactionId in $status/transactionId
                    return
                        <transactionId>{ data($transactionId) }</transactionId>
                }
            </TELLERREFCOLLCASHWSCOPYType>
        </ns0:EliminacionpagorecaudorefTT>
};

declare variable $autenticacionRequestHeader as element(ns1:AutenticacionRequestHeader) external;
declare variable $status as element() external;

xf:eliminacionPagoRecaudoReferenciadoTTIn($autenticacionRequestHeader,
    $status)