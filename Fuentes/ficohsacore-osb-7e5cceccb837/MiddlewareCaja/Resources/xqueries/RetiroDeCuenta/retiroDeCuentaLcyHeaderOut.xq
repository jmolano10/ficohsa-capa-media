(:: pragma bea:global-element-parameter parameter="$retiroenmonedalocalResponse1" element="ns0:RetiroenmonedalocalResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeCuenta/retiroDeCuentaLcyHeaderOut/";

declare function xf:retiroDeCuentaLcyHeaderOut($retiroenmonedalocalResponse1 as element(ns0:RetiroenmonedalocalResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($retiroenmonedalocalResponse1/Status/successIndicator/text())
                let $transactionId := fn:string($retiroenmonedalocalResponse1/Status/transactionId/text())
                return
                if ($successIndicator = "Success") then (
                    <transactionId>{ data($transactionId) }</transactionId>
                ) else (
                )                    
            }
            {
                for $successIndicator in $retiroenmonedalocalResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $retiroenmonedalocalResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE2 in $retiroenmonedalocalResponse1/TELLERType/VALUEDATE2
                return
                    <valueDate>{ data($VALUEDATE2) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $retiroenmonedalocalResponse1 as element(ns0:RetiroenmonedalocalResponse) external;

xf:retiroDeCuentaLcyHeaderOut($retiroenmonedalocalResponse1)