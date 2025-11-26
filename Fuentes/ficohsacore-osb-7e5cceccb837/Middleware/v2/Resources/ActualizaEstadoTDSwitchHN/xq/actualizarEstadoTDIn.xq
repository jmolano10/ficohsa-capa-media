(:: pragma bea:global-element-parameter parameter="$actualizaEstadoTDSwitch" element="ns1:actualizaEstadoTDSwitch" location="../../ActualizaEstadoTDSwitch/xsd/actualizaEstadoTDSwitchTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/DEBITCARD/actualizarEstadoTD/xsd/actualizarEstadoTD_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTD";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoTDSwitchTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoTDSwitch/xq/actualizarEstadoTDIn/";

declare function xf:actualizarEstadoTDIn($actualizaEstadoTDSwitch as element(ns1:actualizaEstadoTDSwitch),
	$bitmap as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:P_EXTERNAL_MESSAGE>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'EXTERNAL_MESSAGE']/VALUE) }</ns0:P_EXTERNAL_MESSAGE>
            <ns0:P_PRODUCT_INDICATOR>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'PRODUCT_INDICATOR']/VALUE) }</ns0:P_PRODUCT_INDICATOR>
            <ns0:P_FIELD_SETTING>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'FIELD_SETTING']/VALUE) }</ns0:P_FIELD_SETTING>
            <ns0:P_STATUS_INDICATOR>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'STATUS_INDICATOR']/VALUE) }</ns0:P_STATUS_INDICATOR>
            <ns0:P_INTERFACE_HOST>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'INTERFACE_HOST']/VALUE) }</ns0:P_INTERFACE_HOST>
            <ns0:P_RESPONSE_CODE>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'RESPONSE_CODE']/VALUE) }</ns0:P_RESPONSE_CODE>
            <ns0:P_MESSAGE_TYPE_INDICATOR>{ data($actualizaEstadoTDSwitch/HEADER_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'MESSAGE_TYPE_INDICATOR']/VALUE) }</ns0:P_MESSAGE_TYPE_INDICATOR>
            <ns0:P_P1_SECONDARY_BITMAP>{ $bitmap }</ns0:P_P1_SECONDARY_BITMAP>
            <ns0:P_P2_PRIMARY_ACCOUNT_NUMBER>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'P2_PRIMARY_ACCOUNT_NUMBER']/VALUE) }</ns0:P_P2_PRIMARY_ACCOUNT_NUMBER>
            <ns0:P_P7_TRANSMISSION_DATETIME>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'P7_TRANSMISSION_DATETIME']/VALUE) }</ns0:P_P7_TRANSMISSION_DATETIME>
            <ns0:P_P11_SYS_TRACE_AUDITNUMBER>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'P11_SYSTEM_TRACE_AUDIT_NUMBER']/VALUE) }</ns0:P_P11_SYS_TRACE_AUDITNUMBER>
            <ns0:P_P48_ADDITIONAL_DATA>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'P48_ADDITIONAL_DATA']/VALUE) }</ns0:P_P48_ADDITIONAL_DATA>
            <ns0:P_P49_TXN_CURRENCY_CODE>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'P49_TRANSACTION_CURRENCY_CODE']/VALUE) }</ns0:P_P49_TXN_CURRENCY_CODE>
            <ns0:P_P60_PRODUCT_INDICATOR_DATA>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'P60_PRODUCT_INDICATOR_DATA']/VALUE) }</ns0:P_P60_PRODUCT_INDICATOR_DATA>
            <ns0:P_S91_FILE_UPDATE_CODE>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'S91_FILE_UPDATE_CODE']/VALUE) }</ns0:P_S91_FILE_UPDATE_CODE>
            <ns0:P_S101_FILE_NAME>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'S101_FILE_NAME']/VALUE) }</ns0:P_S101_FILE_NAME>
            <ns0:P_S120_APP_FILE_AND_TABLE_INFO>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'S120_APP_FILE_TABLE_INFO']/VALUE) }</ns0:P_S120_APP_FILE_AND_TABLE_INFO>
            <ns0:P_S121_APP_FILE_AND_TABLE_INFO>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'S121_APP_FILE_TABLE_INFO']/VALUE) }</ns0:P_S121_APP_FILE_AND_TABLE_INFO>
            <ns0:P_S122_APP_FILE_AND_TABLE_INFO>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'S122_APP_FILE_TABLE_INFO']/VALUE) }</ns0:P_S122_APP_FILE_AND_TABLE_INFO>
            <ns0:P_S126_APP_FILE_AND_TABLE_INFO>{ data($actualizaEstadoTDSwitch/BODY_MESSAGE_DETAILS/ITEM[fn:upper-case(KEY) = 'S126_APP_FILE_TABLE_INFO']/VALUE) }</ns0:P_S126_APP_FILE_AND_TABLE_INFO>
        </ns0:InputParameters>
};

declare variable $actualizaEstadoTDSwitch as element(ns1:actualizaEstadoTDSwitch) external;
declare variable $bitmap as xs:string external;

xf:actualizarEstadoTDIn($actualizaEstadoTDSwitch,
	$bitmap)