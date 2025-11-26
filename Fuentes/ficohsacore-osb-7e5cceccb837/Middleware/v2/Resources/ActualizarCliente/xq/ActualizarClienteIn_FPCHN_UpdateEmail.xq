(:: pragma bea:local-element-parameter parameter="$itemInfo" type="ns1:UpdateCustomerRequest/ns1:CUSTOMER_INFO/ns1:INFO_ITEM" location="../xsd/UpdateCustomerTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/actualizaEmailPersona/xsd/actualizaEmailPersonaFPC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/UpdateCustomerTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEmailPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarCliente/xq/ActualizarClienteIn_FPCHN_UpdateEmail/";

declare function local:decode-values($target as xs:string, $fieldname as xs:string, $fieldvalue as xs:string) as xs:string
{	
	let $e := element{fn:concat($target,'_',$fieldname,'_',$fieldvalue)}{}
	return
		typeswitch($e)
			case element(FPCHN_YESNO_YES) return 'S'
			case element(FPCHN_YESNO_NO) return 'N'
		default return '' 				 
};

declare function local:get-emailuser($target as xs:string) as xs:string
{
	fn:string(fn:tokenize($target,'@')[1])		
};

declare function local:get-emaildomain($target as xs:string) as xs:string
{
	fn:string(fn:tokenize($target,'@')[2])		
};


declare function xf:ActualizarClienteIn_FPCHN_UpdateEmail($customerCode as xs:string,
    $itemInfo as element(),
    $ARRAYINDEX as xs:integer)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_COD_PERSONA>{ $customerCode }</ns0:PC_COD_PERSONA>
            <ns0:PC_COD_EMAIL>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='EMAIL_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_EMAIL>
            <ns0:PC_TIPO_ACCION>2</ns0:PC_TIPO_ACCION>
            <ns0:PC_EMAIL_USUARIO>{ local:get-emailuser(data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='EMAIL_ADDRESS']/ns1:FIELDVALUE)) }</ns0:PC_EMAIL_USUARIO>
            <ns0:PC_EMAIL_SERVIDOR>{ local:get-emaildomain(data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='EMAIL_ADDRESS']/ns1:FIELDVALUE)) }</ns0:PC_EMAIL_SERVIDOR>
            <ns0:PC_ES_DEFAULT>{ local:decode-values('FPCHN','YESNO',data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='IS_DEFAULT']/ns1:FIELDVALUE)) }</ns0:PC_ES_DEFAULT>
        </ns0:InputParameters>
};

declare variable $customerCode as xs:string external;
declare variable $itemInfo as element() external;
declare variable $ARRAYINDEX as xs:integer external;

xf:ActualizarClienteIn_FPCHN_UpdateEmail($customerCode,
    $itemInfo,
    $ARRAYINDEX)