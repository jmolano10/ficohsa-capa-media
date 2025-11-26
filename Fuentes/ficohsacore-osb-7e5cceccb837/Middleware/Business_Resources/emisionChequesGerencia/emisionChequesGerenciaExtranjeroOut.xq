(:: pragma bea:global-element-parameter parameter="$emisiondechequedegerenciaFCYResponse" element="ns0:EmisiondechequedegerenciaFCYResponse" location="Resources/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:emisionChequesGerenciaResponse" location="emisionChequesGerenciaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaExtranjeroOut/";

declare function xf:emisionChequesGerenciaExtranjeroOut($emisiondechequedegerenciaFCYResponse as element(ns0:EmisiondechequedegerenciaFCYResponse))
    as element(ns1:emisionChequesGerenciaResponse) {
        <ns1:emisionChequesGerenciaResponse>
            {
                for $DEBITACCTNO in $emisiondechequedegerenciaFCYResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITAMOUNT in $emisiondechequedegerenciaFCYResponse/FUNDSTRANSFERType/CREDITAMOUNT
                return
                    <CHEQUE_AMOUNT>{ data($CREDITAMOUNT) }</CHEQUE_AMOUNT>
            }
            {
                let $result :=
                    let $BENCUSTOMER := $emisiondechequedegerenciaFCYResponse/FUNDSTRANSFERType/gBENCUSTOMER/BENCUSTOMER
                    return
                        <BENEFICIARY_NAME>{ data($BENCUSTOMER) }</BENEFICIARY_NAME>
                return
                    $result[1]
            }
        </ns1:emisionChequesGerenciaResponse>
};

declare variable $emisiondechequedegerenciaFCYResponse as element(ns0:EmisiondechequedegerenciaFCYResponse) external;

xf:emisionChequesGerenciaExtranjeroOut($emisiondechequedegerenciaFCYResponse)