(:: pragma bea:global-element-parameter parameter="$creaCuentaClienteIN" element="ns0:creaCuentaCliente" location="../../AperturaProductos/xsd/aperturaProductosTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$requestHeaderIN" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/Cobis/AperturaCuenta/xsd/OSB_Apertura_Cuenta_sp.xsd" ::)

declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/OSB_Apertura_Cuenta";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaProductosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaCuentaCliente/xq/creaCuentaClienteIN/";

declare function type-of-currency 
  ( $sector as xs:string )  as xs:string {
  if (fn:string($sector) = "NIO") then (
  	"0")
  	elseif (fn:string($sector) = "USD") then (
  	"1")
  else (
  	""
  )
};

declare function xf:creaCuentaClienteIN($creaCuentaClienteIN as element(ns0:creaCuentaCliente),
    $requestHeaderIN as element(ns2:RequestHeader),
    $Date as xs:string,
    $CodeTransaction as xs:string,
    $Channel as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_pais>{ data($requestHeaderIN/Region/SourceBank) }</ns1:i_pais>
            <ns1:i_canal>{ $Channel }</ns1:i_canal>
            <ns1:i_user>{ data($requestHeaderIN/Authentication/UserName) }</ns1:i_user>
            <ns1:i_fecha>{ data($Date) }</ns1:i_fecha>
            <ns1:t_trn>{ data($CodeTransaction) }</ns1:t_trn>
            <ns1:i_oficina></ns1:i_oficina>
            <ns1:i_cliente>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/CUSTOMER_ID) }</ns1:i_cliente>
            <ns1:i_moneda>{ type-of-currency(data($creaCuentaClienteIN/ACCOUNT_INFORMATION/CURRENCY)) }</ns1:i_moneda>
            <ns1:i_benef1>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/BENEFICIARY_NAME) }</ns1:i_benef1>
            {
                for $NATIONALITY in $creaCuentaClienteIN/ACCOUNT_INFORMATION/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/NATIONALITY
                return
                    <ns1:i_cod_nac>{ data($NATIONALITY) }</ns1:i_cod_nac>
            }
            <ns1:i_parentesco>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/RELATION_CODE) }</ns1:i_parentesco>
            {
                for $DOCUMENT_TYPE in $creaCuentaClienteIN/ACCOUNT_INFORMATION/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/DOCUMENT_TYPE
                return
                    <ns1:i_tipo_doc>{ data($DOCUMENT_TYPE) }</ns1:i_tipo_doc>
            }
            {
                for $LEGAL_ID in $creaCuentaClienteIN/ACCOUNT_INFORMATION/BENEFICIARY_DETAILS/BENEFICIARY_DETAIL[1]/LEGAL_ID
                return
                    <ns1:i_documento>{ data($LEGAL_ID) }</ns1:i_documento>
            }
            <ns1:i_proposito_cta>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/PURPOSE) }</ns1:i_proposito_cta>
            <ns1:i_origen_fondos>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/ORIGEN_OF_FUNDS) }</ns1:i_origen_fondos>
            <ns1:i_num_tran_deb>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/NUMBER_DEBIT_TRANSACTIONS) }</ns1:i_num_tran_deb>
            <ns1:i_monto_pro_deb>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/AMOUNT_DEBIT_AVERAGE) }</ns1:i_monto_pro_deb>
            <ns1:i_num_tran_cre>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/NUMBER_CREDIT_TRANSACTIONS) }</ns1:i_num_tran_cre>
            <ns1:i_monto_pro_cre>{ data($creaCuentaClienteIN/ACCOUNT_INFORMATION/AMOUNT_CREDIT_AVERAGE) }</ns1:i_monto_pro_cre>
            <ns1:i_lugar_entrega_td>{ data($creaCuentaClienteIN/PACKAGING_INFORMATION/DELIVERY_ADDRESS_INFO/ADDRESS_ITEM[1]/ADDRESS_TYPE) }</ns1:i_lugar_entrega_td>
        </ns1:InputParameters>
};

declare variable $creaCuentaClienteIN as element(ns0:creaCuentaCliente) external;
declare variable $requestHeaderIN as element(ns2:RequestHeader) external;
declare variable $Date as xs:string external;
declare variable $CodeTransaction as xs:string external;
declare variable $Channel as xs:string external;

xf:creaCuentaClienteIN($creaCuentaClienteIN,
    $requestHeaderIN,
    $Date,
    $CodeTransaction,
    $Channel)
