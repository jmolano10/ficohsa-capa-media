(:: pragma bea:global-element-parameter parameter="$pagoderemesasResponse" element="ns0:PagoderemesasResponse" location="../../xsds/Remesas/XMLSchema_-1855765488.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoRemesas/PagoRemesasHeaderOut/";

declare function xf:PagoRemesasHeaderOut($pagoderemesasResponse as element(ns0:PagoderemesasResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $transactionId in $pagoderemesasResponse/Status/transactionId
                return
                    <transactionId>{ data($transactionId) }</transactionId>
            }
            {
                for $successIndicator in $pagoderemesasResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoderemesasResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
            {
                for $VALUEDATE2 in $pagoderemesasResponse/TELLERType/VALUEDATE2
                return
                    <valueDate>{ data($VALUEDATE2) }</valueDate>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderemesasResponse as element(ns0:PagoderemesasResponse) external;

xf:PagoRemesasHeaderOut($pagoderemesasResponse)