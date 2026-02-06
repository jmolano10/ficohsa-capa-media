xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$enviaVerificacionOTP" element="ns1:enviaVerificacionOTP" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/EnviaVerificacionOTP/xsd/enviaVerificacionOTP_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/enviaVerificacionOTP";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnviaVerificacionOTP/xq/enviaVerificacionOTPIn/";

declare function xf:enviaVerificacionOTPIn($enviaVerificacionOTP as element(ns1:enviaVerificacionOTP))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REQUESTID>{ data($enviaVerificacionOTP/REQUEST_ID) }</ns0:PV_REQUESTID>
            <ns0:PV_INSTITUTIONCODE>{ data($enviaVerificacionOTP/INSTITUTION_CODE) }</ns0:PV_INSTITUTIONCODE>
            <ns0:PV_PROCESSID>{ data($enviaVerificacionOTP/PROCESS_ID) }</ns0:PV_PROCESSID>
            <ns0:PV_TOKENREFID>{ data($enviaVerificacionOTP/TOKEN_REF_ID) }</ns0:PV_TOKENREFID>
            <ns0:PV_PANREFID>{ data($enviaVerificacionOTP/PAN_REF_ID) }</ns0:PV_PANREFID>
            <ns0:PV_AUTHENTICATIONMETHOD>{ data($enviaVerificacionOTP/AUTHENTICATION_METHOD) }</ns0:PV_AUTHENTICATIONMETHOD>
            <ns0:PV_OTP>{ data($enviaVerificacionOTP/OTP) }</ns0:PV_OTP>
            <ns0:PV_OTPEXPIRATION>{ data($enviaVerificacionOTP/OTP_EXPIRATION) }</ns0:PV_OTPEXPIRATION>
            <ns0:PV_VAULTIDENTIFICATION>{ data($enviaVerificacionOTP/VAULT_IDENTIFICATION) }</ns0:PV_VAULTIDENTIFICATION>
            {
                for $WALLET_ID in $enviaVerificacionOTP/WALLET_ID
                return
                    <ns0:PV_WALLETID>{ data($WALLET_ID) }</ns0:PV_WALLETID>
            }
            {
                for $OTP_REASON_CODE in $enviaVerificacionOTP/OTP_REASON_CODE
                return
                    <ns0:PV_OTPREASONCODE>{ data($OTP_REASON_CODE) }</ns0:PV_OTPREASONCODE>
            }
            <ns0:PV_ENCRYPTEDCARDINFO>
                <ns0:ALGORITHM>{ data($enviaVerificacionOTP/ENCRYPTED_CARD_INFO/ALGORITHM) }</ns0:ALGORITHM>
                {
                    for $NONCE in $enviaVerificacionOTP/ENCRYPTED_CARD_INFO/NONCE
                    return
                        <ns0:NONCE>{ data($NONCE) }</ns0:NONCE>
                }
                {
                    for $IV in $enviaVerificacionOTP/ENCRYPTED_CARD_INFO/IV
                    return
                        <ns0:IV>{ data($IV) }</ns0:IV>
                }
                <ns0:ENCRYPTEDDATA>{ data($enviaVerificacionOTP/ENCRYPTED_CARD_INFO/ENCRYPTED_DATA) }</ns0:ENCRYPTEDDATA>
                {
                    for $ASSOCIATED_DATA in $enviaVerificacionOTP/ENCRYPTED_CARD_INFO/ASSOCIATED_DATA
                    return
                        <ns0:ASSOCIATEDDATA>{ data($ASSOCIATED_DATA) }</ns0:ASSOCIATEDDATA>
                }
                <ns0:MACLENGTH>{ data($enviaVerificacionOTP/ENCRYPTED_CARD_INFO/MAC_LENGTH) }</ns0:MACLENGTH>
            </ns0:PV_ENCRYPTEDCARDINFO>
        </ns0:InputParameters>
};

declare variable $enviaVerificacionOTP as element(ns1:enviaVerificacionOTP) external;

xf:enviaVerificacionOTPIn($enviaVerificacionOTP)