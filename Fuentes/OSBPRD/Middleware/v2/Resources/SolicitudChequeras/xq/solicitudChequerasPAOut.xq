(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKPA/solcitudChequeras/xsd/solicitudChequeras_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:solicitudChequerasResponse" location="../xsd/solicitudChequerasTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/solicitudChequeras";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/solicitudChequerasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/SolicitudChequeras/xq/solicitudChequerasPAOut/";

declare function xf:solicitudChequerasPAOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:solicitudChequerasResponse) {
        <ns1:solicitudChequerasResponse>
            <ns1:solicitudChequerasResponseType>
                <ns1:solicitudChequerasResponseRecordType>
                    <ACCOUNT_NUMBER>{ data($outputParameters/ns0:PV_ACCOUNT_NUMBER) }</ACCOUNT_NUMBER>
                    <DESTINATION_BRANCH>{ data($outputParameters/ns0:PV_DESTINATION_BRANCH) }</DESTINATION_BRANCH>
                    <CHEQUEBOOK_TYPE>{ data($outputParameters/ns0:PV_CHEQUEBOOK_TYPE) }</CHEQUEBOOK_TYPE>
                    <NO_OF_BOOKS>{ data($outputParameters/ns0:PV_NO_OF_BOOKS) }</NO_OF_BOOKS>
                    <FIRST_CHEQUE_NUMBER>{ data($outputParameters/ns0:PV_FIRST_CHEQUE_NO) }</FIRST_CHEQUE_NUMBER>
                    <LAST_CHEQUE_NUMBER>{ data($outputParameters/ns0:PV_LAST_CHEQUE_NO) }</LAST_CHEQUE_NUMBER>
                    <AUTHORIZED_CLAIMER>{ data($outputParameters/ns0:PV_AUTHORIZED_CLAIMER) }</AUTHORIZED_CLAIMER>
                    <DATE_TIME>{ data($outputParameters/ns0:PV_DATE_TIME) }</DATE_TIME>
                </ns1:solicitudChequerasResponseRecordType>
            </ns1:solicitudChequerasResponseType>
        </ns1:solicitudChequerasResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:solicitudChequerasPAOut($outputParameters)