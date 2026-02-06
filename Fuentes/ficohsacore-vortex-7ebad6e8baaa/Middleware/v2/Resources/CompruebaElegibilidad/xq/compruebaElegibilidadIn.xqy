xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$compruebaElegibilidad" element="ns0:compruebaElegibilidad" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CompruebaElegibilidad/xsd/compruebaElegibilidad_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/compruebaElegibilidad";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CompruebaElegibilidad/xq/compruebaElegibilidadIn/";

declare function xf:compruebaElegibilidadIn($compruebaElegibilidad as element(ns0:compruebaElegibilidad), $decryptData as xs:string
)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_REQUESTID>{ data($compruebaElegibilidad/REQUEST_ID) }</ns1:PV_REQUESTID>
            <ns1:PV_INSTITUTIONCODE>{ data($compruebaElegibilidad/INSTITUTION_CODE) }</ns1:PV_INSTITUTIONCODE>
            <ns1:PV_VAULTIDENTIFICATION>{ data($compruebaElegibilidad/VAULT_IDENTIFICATION) }</ns1:PV_VAULTIDENTIFICATION>
            {
                for $WALLET_ID in $compruebaElegibilidad/WALLET_ID
                return
                    <ns1:PV_WALLETID>{ data($WALLET_ID) }</ns1:PV_WALLETID>
            }
            <ns1:PV_TOKENREQUESTORID>{ data($compruebaElegibilidad/TOKEN_REQUESTOR_ID) }</ns1:PV_TOKENREQUESTORID>
            <ns1:PV_TOKENREQUESTORNAME>{ data($compruebaElegibilidad/TOKEN_REQUESTOR_NAME) }</ns1:PV_TOKENREQUESTORNAME>
            {
                for $TOKEN_REF_ID in $compruebaElegibilidad/TOKEN_REF_ID
                return
                    <ns1:PV_TOKENREFID>{ data($TOKEN_REF_ID) }</ns1:PV_TOKENREFID>
            }
            {
                for $PAN_REF_ID in $compruebaElegibilidad/PAN_REF_ID
                return
                    <ns1:PV_PANREFID>{ data($PAN_REF_ID) }</ns1:PV_PANREFID>
            }
            <ns1:PT_ENCRYPTEDCARDINFO>
                <ns1:ALGORITHM>{ data($compruebaElegibilidad/ENCRYPTED_CARD_INFO/ALGORITHM) }</ns1:ALGORITHM>
                {
                    for $NONCE in $compruebaElegibilidad/ENCRYPTED_CARD_INFO/NONCE
                    return
                        <ns1:NONCE>{ data($NONCE) }</ns1:NONCE>
                }
                {
                    for $IV in $compruebaElegibilidad/ENCRYPTED_CARD_INFO/IV
                    return
                        <ns1:IV>{ data($IV) }</ns1:IV>
                }
                <ns1:ENCRYPTEDDATA>{ data($decryptData) }</ns1:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $compruebaElegibilidad/ENCRYPTED_CARD_INFO/ASSOCIATED_DATA
                    return
                        <ns1:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns1:ASSOCIATEDDATA>
                }
                <ns1:MACLENGTH>{ data($compruebaElegibilidad/ENCRYPTED_CARD_INFO/MAC_LENGTH) }</ns1:MACLENGTH>
            </ns1:PT_ENCRYPTEDCARDINFO>
            <ns1:PV_PROCESSID>{ data($compruebaElegibilidad/PROCESS_ID) }</ns1:PV_PROCESSID>
            {
                for $USER_LANGUAGE in $compruebaElegibilidad/USER_LANGUAGE
                return
                    <ns1:PV_USERLANGUAGE>{ data($USER_LANGUAGE) }</ns1:PV_USERLANGUAGE>
            }
            <ns1:PV_SOURCE>{ data($compruebaElegibilidad/SOURCE) }</ns1:PV_SOURCE>
            <ns1:PT_RISKINFORMATION>
                {
                    for $RECOMMENDED_DECISION in $compruebaElegibilidad/RISK_INFORMATION/RECOMMENDED_DECISION
                    return
                        <ns1:RECOMMENDEDDECISION>{ data($RECOMMENDED_DECISION) }</ns1:RECOMMENDEDDECISION>
                }
                {
                    for $DEVICE_SCORE in $compruebaElegibilidad/RISK_INFORMATION/DEVICE_SCORE
                    return
                        <ns1:DEVICESCORE>{ data($DEVICE_SCORE) }</ns1:DEVICESCORE>
                }
                {
                    for $ACCOUNT_SCORE in $compruebaElegibilidad/RISK_INFORMATION/ACCOUNT_SCORE
                    return
                        <ns1:ACCOUNTSCORE>{ data($ACCOUNT_SCORE) }</ns1:ACCOUNTSCORE>
                }
            </ns1:PT_RISKINFORMATION>
            {
                for $RISK_INFORMATION_RESUBMISSION in $compruebaElegibilidad/RISK_INFORMATION_RESUBMISSION
                return
                    <ns1:PB_RISKINFORMATIONRESUBMISSION>{ data($RISK_INFORMATION_RESUBMISSION) }</ns1:PB_RISKINFORMATIONRESUBMISSION>
            }
            <ns1:PV_TOKENTYPE>{ data($compruebaElegibilidad/TOKEN_TYPE) }</ns1:PV_TOKENTYPE>
            <ns1:PV_RECOMMENDEDDECISION>{ data($compruebaElegibilidad/RECOMMENDED_DECISION) }</ns1:PV_RECOMMENDEDDECISION>
            {
                for $RECOMMENDED_DECISION_REASON_CODE in $compruebaElegibilidad/RECOMMENDED_DECISION_REASON_CODE
                return
                    <ns1:PV_RECOMMENDEDDECISIONREASONCODE>{ data($RECOMMENDED_DECISION_REASON_CODE) }</ns1:PV_RECOMMENDEDDECISIONREASONCODE>
            }
        </ns1:InputParameters>
};

declare variable $compruebaElegibilidad as element(ns0:compruebaElegibilidad) external;
declare variable $decryptData as xs:string external;


xf:compruebaElegibilidadIn($compruebaElegibilidad, $decryptData)