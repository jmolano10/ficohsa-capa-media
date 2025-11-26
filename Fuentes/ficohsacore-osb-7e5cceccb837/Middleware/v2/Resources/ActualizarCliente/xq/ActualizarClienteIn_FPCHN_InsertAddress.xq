(:: pragma bea:local-element-parameter parameter="$itemInfo" type="ns1:UpdateCustomerRequest/ns1:CUSTOMER_INFO/ns1:INFO_ITEM" location="../xsd/UpdateCustomerTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/actualizaDireccionPersona/xsd/actualizaDireccionPersonaFPC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/UpdateCustomerTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaDireccionPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarCliente/xq/ActualizarClienteIn_FPCHN_InsertAddress/";

declare function local:decode-values($target as xs:string, $fieldname as xs:string, $fieldvalue as xs:string) as xs:string
{	
	let $e := element{fn:concat($target,'_',$fieldname,'_',$fieldvalue)}{}
	return
		typeswitch($e)
			case element(FPCHN_YESNO_YES) return 'S'
			case element(FPCHN_YESNO_NO) return 'N'
			case element(FPCHN_ADDRESSTYPE_HOME) return 'C'		
			case element(FPCHN_ADDRESSTYPE_WORK) return 'T'
			case element(FPCHN_ADDRESSTYPE_MAILBOX) return 'R'
			case element(FPCHN_ADDRESSTYPE_OTHER) return 'O'
		default return '' 				 
};

declare function xf:ActualizarClienteIn_FPCHN_InsertAddress($customerCode as xs:string,
    $itemInfo as element(),
    $ARRAYINDEX as xs:integer)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_COD_PERSONA>{ $customerCode }</ns0:PC_COD_PERSONA>
            <ns0:PC_COD_DIRECCION>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='ADDRESS_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_DIRECCION>
            <ns0:PC_TIP_ACCION>1</ns0:PC_TIP_ACCION>
            <ns0:PC_TIP_DIRECCION>{ local:decode-values('FPCHN','ADDRESSTYPE',data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='ADDRESS_TYPE']/ns1:FIELDVALUE)) }</ns0:PC_TIP_DIRECCION>
            <ns0:PC_APARTADO_POSTAL>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='POBOX']/ns1:FIELDVALUE) }</ns0:PC_APARTADO_POSTAL>
            <ns0:PC_COD_POSTAL>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='ZIP_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_POSTAL>
            <ns0:PC_DETALLE>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='DETAILS']/ns1:FIELDVALUE) }</ns0:PC_DETALLE>
            <ns0:PC_COD_PAIS>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='COUNTRY_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_PAIS>
            <ns0:PC_COD_PROVINCIA>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='DEPARTMENT_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_PROVINCIA>
            <ns0:PC_COD_CANTON>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='MUNICIPALITY_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_CANTON>
            <ns0:PC_COD_DISTRITO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='CITY_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_DISTRITO>
            <ns0:PC_COD_PUEBLO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='DISTRICT_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_PUEBLO>
            <ns0:PC_DES_DOMICILIO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='DOMICILE']/ns1:FIELDVALUE) }</ns0:PC_DES_DOMICILIO>
            <ns0:PC_DES_EDIFICIO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='BUILDING']/ns1:FIELDVALUE) }</ns0:PC_DES_EDIFICIO>
            <ns0:PC_DES_PISO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='FLOOR']/ns1:FIELDVALUE) }</ns0:PC_DES_PISO>
            <ns0:PC_DES_APTO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='APARTMENT']/ns1:FIELDVALUE) }</ns0:PC_DES_APTO>
            <ns0:PC_ES_DEFAULT>{ local:decode-values('FPCHN','YESNO',data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='IS_DEFAULT']/ns1:FIELDVALUE)) }</ns0:PC_ES_DEFAULT>
        </ns0:InputParameters>
};

declare variable $customerCode as xs:string external;
declare variable $itemInfo as element() external;
declare variable $ARRAYINDEX as xs:integer external;

xf:ActualizarClienteIn_FPCHN_InsertAddress($customerCode,
    $itemInfo,
    $ARRAYINDEX)