(:: pragma bea:global-element-parameter parameter="$retirodeefecenmonextranjeraResponse1" element="ns0:RetirodeefecenmonextranjeraResponse" location="../../xsds/RetirosYPagos/XMLSchema_1006378181.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/RetiroDeCuenta/retiroDeCuentaFcyHeaderOut/";

declare function xf:retiroDeCuentaFcyHeaderOut($retirodeefecenmonextranjeraResponse1 as element(ns0:RetirodeefecenmonextranjeraResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($retirodeefecenmonextranjeraResponse1/Status/successIndicator/text())
                let $transactionId := fn:string($retirodeefecenmonextranjeraResponse1/Status/transactionId/text())
                return
                if ($successIndicator = "Success") then (
                    <transactionId>{ data($transactionId) }</transactionId>
                ) else (
                )                      
            }
            {
                for $successIndicator in $retirodeefecenmonextranjeraResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $retirodeefecenmonextranjeraResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE2 in $retirodeefecenmonextranjeraResponse1/TELLERType/VALUEDATE2
                return
                    <valueDate>{ data($VALUEDATE2) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $retirodeefecenmonextranjeraResponse1 as element(ns0:RetirodeefecenmonextranjeraResponse) external;

xf:retiroDeCuentaFcyHeaderOut($retirodeefecenmonextranjeraResponse1)