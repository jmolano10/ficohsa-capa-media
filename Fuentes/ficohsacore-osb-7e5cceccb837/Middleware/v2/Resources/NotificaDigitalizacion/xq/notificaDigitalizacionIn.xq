(:: pragma bea:global-element-parameter parameter="$notificaDigitalizacion" element="ns1:notificaDigitalizacion" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/NotificaDigitalizacion/xsd/notificaDigitalizacion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/notificaDigitalizacion";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/NotificaDigitalizacion/xq/notificaDigitalizacionIn/";

declare function xf:notificaDigitalizacionIn($notificaDigitalizacion as element(ns1:notificaDigitalizacion))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REQUESTID>{ data($notificaDigitalizacion/REQUEST_ID) }</ns0:PV_REQUESTID>
            <ns0:PV_INSTITUTIONCODE>{ data($notificaDigitalizacion/INSTITUTION_CODE) }</ns0:PV_INSTITUTIONCODE>
            <ns0:PV_PROCESSID>{ data($notificaDigitalizacion/PROCESS_ID) }</ns0:PV_PROCESSID>
            <ns0:PV_VAULTIDENTIFICATION>{ data($notificaDigitalizacion/VAULT_IDENTIFICATION) }</ns0:PV_VAULTIDENTIFICATION>
            {
                for $WALLET_ID in $notificaDigitalizacion/WALLET_ID
                return
                    <ns0:PV_WALLETID>{ data($WALLET_ID) }</ns0:PV_WALLETID>
            }
            <ns0:PV_TOKENTYPE>{ data($notificaDigitalizacion/TOKEN_TYPE) }</ns0:PV_TOKENTYPE>
            <ns0:PV_DATETIME>{ data($notificaDigitalizacion/DATETIME) }</ns0:PV_DATETIME>
            <ns0:PV_EVENT>{ data($notificaDigitalizacion/EVENT) }</ns0:PV_EVENT>
            <ns0:PV_TOKENREQUESTORID>{ data($notificaDigitalizacion/TOKEN_REQUESTOR_ID) }</ns0:PV_TOKENREQUESTORID>
            <ns0:PV_TOKENREFID>{ data($notificaDigitalizacion/TOKEN_REF_ID) }</ns0:PV_TOKENREFID>
            <ns0:PV_PANREFID>{ data($notificaDigitalizacion/PAN_REF_ID) }</ns0:PV_PANREFID>
            <ns0:PT_ENCRYPTEDCARDINFO>
                <ns0:ALGORITHM>{ data($notificaDigitalizacion/ENCRYPTED_CARD_INFO/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $notificaDigitalizacion/ENCRYPTED_CARD_INFO/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $notificaDigitalizacion/ENCRYPTED_CARD_INFO/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($notificaDigitalizacion/ENCRYPTED_CARD_INFO/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $notificaDigitalizacion/ENCRYPTED_CARD_INFO/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($notificaDigitalizacion/ENCRYPTED_CARD_INFO/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PT_ENCRYPTEDCARDINFO>
            <ns0:PV_SOURCE>{ data($notificaDigitalizacion/SOURCE) }</ns0:PV_SOURCE>
            <ns0:PV_ACTIONRESULT>{ data($notificaDigitalizacion/ACTION_RESULT) }</ns0:PV_ACTIONRESULT>
            {
                for $STAND_IN_REASON_CODE in $notificaDigitalizacion/STAND_IN_REASON_CODE
                return
                    <ns0:PV_STANDINREASONCODE>{ data($STAND_IN_REASON_CODE) }</ns0:PV_STANDINREASONCODE>
            }
            <ns0:PT_TERMSANDCONDITIONS>
                {
                    for $ID in $notificaDigitalizacion/TERMS_AND_CONTITIONS/ID
                    return
                        <ns0:ID>{ data($ID) }</ns0:ID>
                }
                {
                    for $DATE in $notificaDigitalizacion/TERMS_AND_CONTITIONS/DATE
                    return
                        <ns0:DATET>{ data($DATE) }</ns0:DATET>
                }
            </ns0:PT_TERMSANDCONDITIONS>
            <ns0:PT_TOKEN>
                <ns0:ALGORITHM>{ data($notificaDigitalizacion/TOKEN/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $notificaDigitalizacion/TOKEN/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $notificaDigitalizacion/TOKEN/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($notificaDigitalizacion/TOKEN/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $notificaDigitalizacion/TOKEN/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($notificaDigitalizacion/TOKEN/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PT_TOKEN>
        </ns0:InputParameters>
};

declare variable $notificaDigitalizacion as element(ns1:notificaDigitalizacion) external;

xf:notificaDigitalizacionIn($notificaDigitalizacion)