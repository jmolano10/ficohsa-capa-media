(:: pragma bea:local-element-parameter parameter="$itemInfo" type="ns1:UpdateCustomerRequest/ns1:CUSTOMER_INFO/ns1:INFO_ITEM" location="../xsd/UpdateCustomerTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/FPC/actualizaTrabajoPersona/xsd/actualizaTrabajoPersonaFPC_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/UpdateCustomerTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaTrabajoPersonaFPC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizarCliente/xq/ActualizarClienteIn_FPCHN_UpdateJob/";


declare function local:format-date-FPC($textdate as xs:string) as xs:string
{
	fn:concat(fn:substring($textdate,1,4),'-',fn:substring($textdate,5,2),'-',fn:substring($textdate,7,2))
};

declare function local:decode-values($target as xs:string, $fieldname as xs:string, $fieldvalue as xs:string) as xs:string
{	
	let $e := element{fn:concat($target,'_',$fieldname,'_',$fieldvalue)}{}
	return
		typeswitch($e)
			case element(FPCHN_YESNO_YES) return 'S'
			case element(FPCHN_YESNO_NO) return 'N'
			case element(FPCHN_INCOMETYPE_SALARY) return 'S'
			case element(FPCHN_INCOMETYPE_FREELANCE) return 'I'
			case element(FPCHN_INCOMETYPE_FEE) return 'H'
			case element(FPCHN_INCOMETYPE_OTHER) return 'O'			
		default return '' 				 
};

declare function xf:ActualizarClienteIn_FPCHN_UpdateJob($customerCode as xs:string,
    $itemInfo as element(),
    $ARRAYINDEX as xs:integer)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PC_COD_PERSONA>{ $customerCode }</ns0:PC_COD_PERSONA>
            <ns0:PC_TIPO_ACCION>2</ns0:PC_TIPO_ACCION>
            <ns0:PC_COD_PATRONAL>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='EMPLOYER_CODE']/ns1:FIELDVALUE)}</ns0:PC_COD_PATRONAL>
            <ns0:PC_TIP_INGRESO>{ local:decode-values('FPCHN','INCOMETYPE',data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='INCOME_TYPE']/ns1:FIELDVALUE))}</ns0:PC_TIP_INGRESO>
            <ns0:PN_MON_DEVENGADO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='SALARY_AMOUNT']/ns1:FIELDVALUE) }</ns0:PN_MON_DEVENGADO>            
            <ns0:PD_FEC_INGRESO>{ local:format-date-FPC(data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='START_DATE']/ns1:FIELDVALUE)) }</ns0:PD_FEC_INGRESO>
            <ns0:PC_COD_CARGO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='JOB_CODE']/ns1:FIELDVALUE) }</ns0:PC_COD_CARGO>
            <ns0:PC_PUESTO>{ data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='JOB_DESCRIPTION']/ns1:FIELDVALUE) }</ns0:PC_PUESTO>
            <ns0:PD_FEC_SALIDA>{ local:format-date-FPC(data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='END_DATE']/ns1:FIELDVALUE)) }</ns0:PD_FEC_SALIDA>
            <ns0:PC_EMPLEO_ACTUAL>{ local:decode-values('FPCHN','YESNO',data($itemInfo/ns1:DATA[$ARRAYINDEX]/ns1:DATA_ITEM[ns1:FIELDNAME='IS_CURRENT_JOB']/ns1:FIELDVALUE)) }</ns0:PC_EMPLEO_ACTUAL>
        </ns0:InputParameters>
};



declare variable $customerCode as xs:string external;
declare variable $itemInfo as element() external;
declare variable $ARRAYINDEX as xs:integer external;

xf:ActualizarClienteIn_FPCHN_UpdateJob($customerCode,
    $itemInfo,
    $ARRAYINDEX)