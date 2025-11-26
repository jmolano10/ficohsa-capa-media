(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosTTResponse" element="ns0:ConsultaChequesPagadosTTResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaChequesPagadosFTResponse" element="ns0:ConsultaChequesPagadosFTResponse" location="../Resources/XMLSchema_516353548.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequesPagadosResponse" location="consultaChequesPagadosTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesPagadosTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaCheque/ConsultaChequesPagados/consultaChequesPagadosOut/";

declare function xf:consultaChequesPagadosOut($consultaChequesPagadosTTResponse as element(ns0:ConsultaChequesPagadosTTResponse),
    $consultaChequesPagadosFTResponse as element(ns0:ConsultaChequesPagadosFTResponse))
    as element(ns1:consultaChequesPagadosResponse) {
        <ns1:consultaChequesPagadosResponse>
            <ns1:consultaChequesPagadosResponseType>
            	{
                    for $mWSTTCHEQUESPRESENTEDDetailType in $consultaChequesPagadosTTResponse/WSTTCHEQUESPRESENTEDType[1]/gWSTTCHEQUESPRESENTEDDetailType/mWSTTCHEQUESPRESENTEDDetailType
                    return
                        <ns1:consultaChequesPagadosResponseRecordType>
                            {
                                for $ID in $mWSTTCHEQUESPRESENTEDDetailType/ID
                                return
                                    <TRANSACTION_ID>{ data($ID) }</TRANSACTION_ID>
                            }
                            {
                                for $CHEQUEACCOUNT in $mWSTTCHEQUESPRESENTEDDetailType/CHEQUEACCOUNT
                                return
                                    <ACCOUNT_NUMBER>{ data($CHEQUEACCOUNT) }</ACCOUNT_NUMBER>
                            }
                            {
                                for $CHEQUENUMBER in $mWSTTCHEQUESPRESENTEDDetailType/CHEQUENUMBER
                                return
                                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                            }
                            {
                                for $CHEQUEAMOUNT in $mWSTTCHEQUESPRESENTEDDetailType/CHEQUEAMOUNT
                                return
                                    <AMOUNT>{ data($CHEQUEAMOUNT) }</AMOUNT>
                            }
                            {
                                for $BRANCHCODE in $mWSTTCHEQUESPRESENTEDDetailType/BRANCHCODE
                                return
                                    <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
                            }
                            {
                                for $CHEQUECURRENCY in $mWSTTCHEQUESPRESENTEDDetailType/CHEQUECURRENCY
                                return
                                    <CURRENCY>{ data($CHEQUECURRENCY) }</CURRENCY>
                            }
                            {
                                for $CHEQUEINPUTTER in $mWSTTCHEQUESPRESENTEDDetailType/CHEQUEINPUTTER
                                return
                                    <INPUTTER>{ data($CHEQUEINPUTTER) }</INPUTTER>
                            }
                        </ns1:consultaChequesPagadosResponseRecordType>
                }
                {
                    for $mWSFTCHEQUESPRESENTEDDetailType in $consultaChequesPagadosFTResponse/WSFTCHEQUESPRESENTEDType[1]/gWSFTCHEQUESPRESENTEDDetailType/mWSFTCHEQUESPRESENTEDDetailType
                    return
                        <ns1:consultaChequesPagadosResponseRecordType>
                            {
                                for $ID in $mWSFTCHEQUESPRESENTEDDetailType/ID
                                return
                                    <TRANSACTION_ID>{ data($ID) }</TRANSACTION_ID>
                            }
                            {
                                for $CHEQUEACCOUNT in $mWSFTCHEQUESPRESENTEDDetailType/CHEQUEACCOUNT
                                return
                                    <ACCOUNT_NUMBER>{ data($CHEQUEACCOUNT) }</ACCOUNT_NUMBER>
                            }
                            {
                                for $CHEQUENUMBER in $mWSFTCHEQUESPRESENTEDDetailType/CHEQUENUMBER
                                return
                                    <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
                            }
                            {
                                for $CHEQUEAMOUNT in $mWSFTCHEQUESPRESENTEDDetailType/CHEQUEAMOUNT
                                return
                                    <AMOUNT>{ data($CHEQUEAMOUNT) }</AMOUNT>
                            }
                            {
                                for $BRANCHCODE in $mWSFTCHEQUESPRESENTEDDetailType/BRANCHCODE
                                return
                                    <BRANCH_CODE>{ data($BRANCHCODE) }</BRANCH_CODE>
                            }
                            {
                                for $CHEQUECURRENCY in $mWSFTCHEQUESPRESENTEDDetailType/CHEQUECURRENCY
                                return
                                    <CURRENCY>{ data($CHEQUECURRENCY) }</CURRENCY>
                            }
                            {
                                for $CHEQUEINPUTTER in $mWSFTCHEQUESPRESENTEDDetailType/CHEQUEINPUTTER
                                return
                                    <INPUTTER>{ data($CHEQUEINPUTTER) }</INPUTTER>
                            }
                        </ns1:consultaChequesPagadosResponseRecordType>
                }
            </ns1:consultaChequesPagadosResponseType>
        </ns1:consultaChequesPagadosResponse>
};

declare variable $consultaChequesPagadosTTResponse as element(ns0:ConsultaChequesPagadosTTResponse) external;
declare variable $consultaChequesPagadosFTResponse as element(ns0:ConsultaChequesPagadosFTResponse) external;

xf:consultaChequesPagadosOut($consultaChequesPagadosTTResponse,
    $consultaChequesPagadosFTResponse)