(:: pragma bea:global-element-parameter parameter="$ordenEmpaqueTD" element="ns1:ordenEmpaqueTD" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:crearOrdenEmpaque" location="../../../BusinessServices/OrdenEmpaqueCloud/wsdl/ordenEmpaqueCloud.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace ns0 = "http://soap.sforce.com/schemas/class/WS_crearOrdenEmpaque";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/OrdenEmpaqueTD/xq/ordenEmpaqueCloudIN/";

declare function xf:ordenEmpaqueCloudIN($ordenEmpaqueTD as element(ns1:ordenEmpaqueTD))
    as element(ns0:crearOrdenEmpaque) {
        <ns0:crearOrdenEmpaque>
            <ns0:legal_id>{ data($ordenEmpaqueTD/CUSTOMER_INFORMATION/LEGAL_ID) }</ns0:legal_id>
            <ns0:client_name>{ data($ordenEmpaqueTD/CUSTOMER_INFORMATION/NAME) }</ns0:client_name>
            <ns0:customer_id>{ data($ordenEmpaqueTD/CUSTOMER_INFORMATION/CODE) }</ns0:customer_id>
            <ns0:account_number>{ data($ordenEmpaqueTD/ACCOUNT_INFORMATION/ACCOUNT_NUMBER) }</ns0:account_number>
            <ns0:email_address>{ data($ordenEmpaqueTD/CUSTOMER_INFORMATION/EMAIL) }</ns0:email_address>
            {
                for $PHONE_NUMBER_ITEM in $ordenEmpaqueTD/PHONE_INFO/PHONE_NUMBER_ITEM
                return
                    <ns0:phone_info>
                        <ns0:phone_number>{ data($PHONE_NUMBER_ITEM/PHONE_NUMBER) }</ns0:phone_number>
                        <ns0:phone_type>{ data($PHONE_NUMBER_ITEM/PHONE_TYPE) }</ns0:phone_type>
                    </ns0:phone_info>
            }
            {
                for $ADDRESS_ITEM in $ordenEmpaqueTD/ADDRESS_INFO/ADDRESS_ITEM
                return
                    <ns0:address_info>
                        <ns0:address_line>{ data($ADDRESS_ITEM/ADDRESS_LINE) }</ns0:address_line>
                        <ns0:address_type>{ data($ADDRESS_ITEM/ADDRESS_TYPE) }</ns0:address_type>
                        <ns0:is_delivery_address>{ data($ADDRESS_ITEM/IS_DELIVERY_ADDRESS) }</ns0:is_delivery_address>
                    </ns0:address_info>
            }
            <ns0:job_info>{ data($ordenEmpaqueTD/JOB_INFO/JOB_ITEM[1]/JOB_DESCRIPTION) }</ns0:job_info>
            {
                let $CARD_INFORMATION := $ordenEmpaqueTD/CARD_INFORMATION
                return
                    <ns0:card_info>
                        <ns0:card_currency>{ data($ordenEmpaqueTD/ACCOUNT_INFORMATION/ACCOUNT_CURRENCY) }</ns0:card_currency>
                        {
                            for $LAST_CARD_NUMBER in $CARD_INFORMATION/LAST_CARD_NUMBER
                            return
                                <ns0:card_number>{ data($LAST_CARD_NUMBER) }</ns0:card_number>
                        }
                        <ns0:product_type>{ data($CARD_INFORMATION/TYPE) }</ns0:product_type>
                    </ns0:card_info>
            }
            <ns0:agency>{ data($ordenEmpaqueTD/CARD_INFORMATION/BRANCH_CODE) }</ns0:agency>
        </ns0:crearOrdenEmpaque>
};

declare variable $ordenEmpaqueTD as element(ns1:ordenEmpaqueTD) external;

xf:ordenEmpaqueCloudIN($ordenEmpaqueTD)
