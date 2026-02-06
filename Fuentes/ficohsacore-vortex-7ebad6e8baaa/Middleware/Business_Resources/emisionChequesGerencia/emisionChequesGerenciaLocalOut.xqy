xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$emisiondechequedegerenciaFTResponse" element="ns0:EmisiondechequedegerenciaFTResponse" location="Resources/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:emisionChequesGerenciaResponse" location="emisionChequesGerenciaTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/emisionChequesGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/emisionChequesGerencia/emisionChequesGerenciaLocalOut/";

declare function xf:emisionChequesGerenciaLocalOut($emisiondechequedegerenciaFTResponse as element(ns0:EmisiondechequedegerenciaFTResponse))
    as element(ns1:emisionChequesGerenciaResponse) {
        <ns1:emisionChequesGerenciaResponse>
            {
                for $DEBITACCTNO in $emisiondechequedegerenciaFTResponse/FUNDSTRANSFERType/DEBITACCTNO
                return
                    <DEBIT_ACCOUNT>{ data($DEBITACCTNO) }</DEBIT_ACCOUNT>
            }
            {
                for $CREDITAMOUNT in $emisiondechequedegerenciaFTResponse/FUNDSTRANSFERType/CREDITAMOUNT
                return
                    <CHEQUE_AMOUNT>{ data($CREDITAMOUNT) }</CHEQUE_AMOUNT>
            }
            {
                let $LRBENNAME := $emisiondechequedegerenciaFTResponse/FUNDSTRANSFERType/LRBENNAME
                return
                    <BENEFICIARY_NAME>{ data($LRBENNAME) }</BENEFICIARY_NAME>
            }
        </ns1:emisionChequesGerenciaResponse>
};

declare variable $emisiondechequedegerenciaFTResponse as element(ns0:EmisiondechequedegerenciaFTResponse) external;

xf:emisionChequesGerenciaLocalOut($emisiondechequedegerenciaFTResponse)