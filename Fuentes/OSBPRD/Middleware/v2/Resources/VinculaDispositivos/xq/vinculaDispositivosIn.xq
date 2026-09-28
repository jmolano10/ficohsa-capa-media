(:: pragma bea:global-element-parameter parameter="$vinculaDispositivos" element="ns1:vinculaDispositivos" location="../../DigitalizacionTarjetas/xsd/digitalizacionTarjetasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/VinculaDispositivos/xsd/vinculaDispositivos_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/vinculaDispositivos";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/digitalizacionTarjetasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/VinculaDispositivos/xq/vinculaDispositivosIn/";

declare function xf:vinculaDispositivosIn($vinculaDispositivos as element(ns1:vinculaDispositivos))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_REQUESTID>{ data($vinculaDispositivos/REQUEST_ID) }</ns0:PV_REQUESTID>
            <ns0:PV_INSTITUTIONCODE>{ data($vinculaDispositivos/INSTITUTION_CODE) }</ns0:PV_INSTITUTIONCODE>
            <ns0:PV_VAULTIDENTIFICATION>{ data($vinculaDispositivos/VAULT_IDENTIFICATION) }</ns0:PV_VAULTIDENTIFICATION>
            {
                for $WALLET_ID in $vinculaDispositivos/WALLET_ID
                return
                    <ns0:PV_WALLETID>{ data($WALLET_ID) }</ns0:PV_WALLETID>
            }
            <ns0:PV_TOKENREQUESTORID>{ data($vinculaDispositivos/TOKEN_REQUESTOR_ID) }</ns0:PV_TOKENREQUESTORID>
            <ns0:PV_TOKENREFID>{ data($vinculaDispositivos/TOKEN_REF_ID) }</ns0:PV_TOKENREFID>
            <ns0:PV_PANREFID>{ data($vinculaDispositivos/PAN_REF_ID) }</ns0:PV_PANREFID>
            <ns0:PD_DEVICEINFO>
                {
                    for $DEVICE_TYPE in $vinculaDispositivos/DEVICE_INFO/DEVICE_TYPE
                    return
                        <ns0:DEVICETYPE>{ data($DEVICE_TYPE) }</ns0:DEVICETYPE>
                }
                {
                    for $DEVICE_NUMBER in $vinculaDispositivos/DEVICE_INFO/DEVICE_NUMBER
                    return
                        <ns0:DEVICENUMBER>{ data($DEVICE_NUMBER) }</ns0:DEVICENUMBER>
                }
                {
                    for $DEVICE_NAME in $vinculaDispositivos/DEVICE_INFO/DEVICE_NAME
                    return
                        <ns0:DEVICENAME>{ data($DEVICE_NAME) }</ns0:DEVICENAME>
                }
                {
                    for $DEVICE_MODEL in $vinculaDispositivos/DEVICE_INFO/DEVICE_MODEL
                    return
                        <ns0:DEVICEMODEL>{ data($DEVICE_MODEL) }</ns0:DEVICEMODEL>
                }
                {
                    for $SERIAL_NUMBER in $vinculaDispositivos/DEVICE_INFO/SERIAL_NUMBER
                    return
                        <ns0:SERIALNUMBER>{ data($SERIAL_NUMBER) }</ns0:SERIALNUMBER>
                }
                {
                    for $DEVICE_ID in $vinculaDispositivos/DEVICE_INFO/DEVICE_ID
                    return
                        <ns0:DEVICEID>{ data($DEVICE_ID) }</ns0:DEVICEID>
                }
                {
                    for $DEVICE_INDEX in $vinculaDispositivos/DEVICE_INFO/DEVICE_INDEX
                    return
                        <ns0:DEVICEINDEX>{ data($DEVICE_INDEX) }</ns0:DEVICEINDEX>
                }
            </ns0:PD_DEVICEINFO>
            <ns0:PT_TOKENUSERINFO>
                <ns0:ID>{ data($vinculaDispositivos/TOKEN_USER_INFO/ID) }</ns0:ID>
                {
                    for $APP_TYPE in $vinculaDispositivos/TOKEN_USER_INFO/APP_TYPE
                    return
                        <ns0:APPTYPE>{ data($APP_TYPE) }</ns0:APPTYPE>
                }
            </ns0:PT_TOKENUSERINFO>
            <ns0:PM_MERCHANTINFO>
                {
                    for $ID in $vinculaDispositivos/MERCHANT_INFO/ID
                    return
                        <ns0:ID>{ data($ID) }</ns0:ID>
                }
                {
                    for $MERCHANT_NAME in $vinculaDispositivos/MERCHANT_INFO/MERCHANT_NAME
                    return
                        <ns0:MERCHANTNAME>{ data($MERCHANT_NAME) }</ns0:MERCHANTNAME>
                }
            </ns0:PM_MERCHANTINFO>
        </ns0:InputParameters>
};

declare variable $vinculaDispositivos as element(ns1:vinculaDispositivos) external;

xf:vinculaDispositivosIn($vinculaDispositivos)