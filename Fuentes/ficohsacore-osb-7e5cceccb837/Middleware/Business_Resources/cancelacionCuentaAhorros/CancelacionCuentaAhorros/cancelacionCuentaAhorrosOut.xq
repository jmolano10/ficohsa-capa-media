(:: pragma bea:global-element-parameter parameter="$cancelaciondecuentaparte2Response1" element="ns0:Cancelaciondecuentaparte2Response" location="../Resources/XMLSchema_1790235882.xsd" ::)
(:: pragma bea:global-element-return element="ns1:cancelacionCuentaAhorrosResponse" location="cancelacionCuentaAhorrosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/cancelacionCuentaAhorrosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/cancelacionCuentaAhorros/CancelacionCuentaAhorros/cancelacionCuentaAhorrosOut/";

declare function xf:cancelacionCuentaAhorrosOut($cancelaciondecuentaparte2Response1 as element(ns0:Cancelaciondecuentaparte2Response))
    as element(ns1:cancelacionCuentaAhorrosResponse) {
        <ns1:cancelacionCuentaAhorrosResponse>
            {
                for $NETAMOUNT in $cancelaciondecuentaparte2Response1/TELLERType/NETAMOUNT
                return
                    <WITHDRAW_AMOUNT>{ data($NETAMOUNT) }</WITHDRAW_AMOUNT>
            }
            {
                for $TELLERID1 in $cancelaciondecuentaparte2Response1/TELLERType/TELLERID1
                return
                    <TELLER_ID>{ data($TELLERID1) }</TELLER_ID>
            }
        </ns1:cancelacionCuentaAhorrosResponse>
};

declare variable $cancelaciondecuentaparte2Response1 as element(ns0:Cancelaciondecuentaparte2Response) external;

xf:cancelacionCuentaAhorrosOut($cancelaciondecuentaparte2Response1)