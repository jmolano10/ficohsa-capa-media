(:: pragma bea:local-element-parameter parameter="$INFO_ITEM" type="ns1:UpdateCustomerRequest/ns1:CUSTOMER_INFO/ns1:INFO_ITEM" location="../xsd/UpdateCustomerTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/actualizaTelefonoPersona/xsd/actualizaTelefonoPersonaFPC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/UpdateCustomerTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaTelefonoPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarCliente/xq/ActualizarClienteIn_FPCHN_UpdatePhoneNumber/";

declare function local:decode-values($target as xs:string, $fieldname as xs:string, $fieldvalue as xs:string) as xs:string
{	
	let $e := element{fn:concat($target,'_',$fieldname,'_',$fieldvalue)}{}
	return
		typeswitch($e)
			case element(FPCHN_YESNO_YES) return 'S'
			case element(FPCHN_YESNO_NO) return 'N'		
			case element(FPCHN_PHONELOCATION_HOME) return 'C'
			case element(FPCHN_PHONELOCATION_WORK) return 'T'
			case element(FPCHN_PHONELOCATION_OTHER) return 'O'
			case element(FPCHN_PHONETYPE_BEEPER) return 'B'
			case element(FPCHN_PHONETYPE_MOBILE) return 'C'
			case element(FPCHN_PHONETYPE_LANDLINE) return 'D'
			case element(FPCHN_PHONETYPE_FAX) return 'F'
			case element(FPCHN_PHONETYPE_PBX) return 'R'
			case element(FPCHN_PHONETYPE_TELEFAX) return 'T'
			case element(FPCHN_PHONETYPE_OTHER) return 'O'	
		default return '' 		
		 
};

declare function xf:ActualizarClienteIn_FPCHN_UpdatePhoneNumber($CUSTOMER_CODE as xs:string,
    $INFO_ITEM as element(), $ARRAYINDEX as xs:integer)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_TIPO_ACCION>2</ns0:PC_TIPO_ACCION>
            <ns0:PC_COD_PERSONA>{ $CUSTOMER_CODE }</ns0:PC_COD_PERSONA>
            <ns0:PC_COD_AREA>{ data($INFO_ITEM/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='AREA_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_AREA>
            <ns0:PC_NUM_TELEFONO>{ data($INFO_ITEM/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='PHONE_NUMBER']/ns1:FIELDVALUE) }</ns0:PC_NUM_TELEFONO>
            <ns0:PC_TIP_TELEFONO>{ local:decode-values('FPCHN','PHONETYPE',data($INFO_ITEM/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='PHONE_TYPE']/ns1:FIELDVALUE)) }</ns0:PC_TIP_TELEFONO>
            <ns0:PC_TEL_UBICACION>{ local:decode-values('FPCHN','PHONELOCATION',data($INFO_ITEM/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='PHONE_LOCATION']/ns1:FIELDVALUE)) }</ns0:PC_TEL_UBICACION>
            <ns0:PC_ES_DEFAULT>{ local:decode-values('FPCHN','YESNO',data($INFO_ITEM/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='IS_DEFAULT']/ns1:FIELDVALUE)) }</ns0:PC_ES_DEFAULT>
        </ns0:InputParameters>
};

declare variable $CUSTOMER_CODE as xs:string external;
declare variable $INFO_ITEM as element() external;
declare variable $ARRAYINDEX as xs:integer external;

xf:ActualizarClienteIn_FPCHN_UpdatePhoneNumber($CUSTOMER_CODE,
    $INFO_ITEM, $ARRAYINDEX)