(:: pragma bea:global-element-parameter parameter="$bloqueodeanticiposenctaahorrosResponse1" element="ns1:BloqueodeanticiposenctaahorrosResponse" location="../../../BusinessServices/T24/AnticiposCliente/xsd/XMLSchema_-361259320.xsd" ::)
(:: pragma bea:global-element-return element="ns0:bloqueaAnticipoCuentaResponse" location="../../BloqueoAnticipoCTA/xsd/bloqueaAnticipoCuentaTypes.xsd" ::)

declare namespace ns1 = "T24WebServicesImpl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/bloqueaAnticipoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoAnticipoCTAHN/xq/BloqueoAnticipoCtaHnBOut/";

declare function xf:BloqueoAnticipoCtaHnBOut($bloqueodeanticiposenctaahorrosResponse1 as element(ns1:BloqueodeanticiposenctaahorrosResponse))
    as element(ns0:bloqueaAnticipoCuentaResponse) {
        <ns0:bloqueaAnticipoCuentaResponse>
            {
                for $CUSTOMER in $bloqueodeanticiposenctaahorrosResponse1/FICOCAEMPLOYEEType/CUSTOMER
                return
                    <CUSTOMER_ID>{ data($CUSTOMER) }</CUSTOMER_ID>
            }
            {
                for $CURRENCY in $bloqueodeanticiposenctaahorrosResponse1/FICOCAEMPLOYEEType/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $id in $bloqueodeanticiposenctaahorrosResponse1/FICOCAEMPLOYEEType/@id
                return
                    <PRODUCT_NUMBER>{ data($id) }</PRODUCT_NUMBER>
            }
        </ns0:bloqueaAnticipoCuentaResponse>
};

declare variable $bloqueodeanticiposenctaahorrosResponse1 as element(ns1:BloqueodeanticiposenctaahorrosResponse) external;

xf:BloqueoAnticipoCtaHnBOut($bloqueodeanticiposenctaahorrosResponse1)