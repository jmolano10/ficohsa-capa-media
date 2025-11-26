xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagodeChequeLCYResponse1" element="ns0:PagodeChequeLCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoDeCheque/pagoDeChequeLcyHeaderOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:pagoDeChequeLcyHeaderOut($pagodeChequeLCYResponse1 as element(ns0:PagodeChequeLCYResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                let $successIndicator := fn:string($pagodeChequeLCYResponse1/Status/successIndicator/text())
                let $transactionId := fn:string($pagodeChequeLCYResponse1/Status/transactionId/text())
                return
                if ($successIndicator = "Success") then (
                    <transactionId>{ data($transactionId) }</transactionId>
                ) else (
                )
            }
            {
                for $successIndicator in $pagodeChequeLCYResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagodeChequeLCYResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE2 in $pagodeChequeLCYResponse1/TELLERType/VALUEDATE2
                return
                    <valueDate>{ data($VALUEDATE2) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $pagodeChequeLCYResponse1 as element(ns0:PagodeChequeLCYResponse) external;

xf:pagoDeChequeLcyHeaderOut($pagodeChequeLCYResponse1)
