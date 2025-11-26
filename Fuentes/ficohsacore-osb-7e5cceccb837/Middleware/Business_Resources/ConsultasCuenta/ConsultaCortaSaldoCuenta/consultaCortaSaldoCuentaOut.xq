(:: pragma bea:global-element-parameter parameter="$consultacortadesaldodecuentaResponse" element="ns0:ConsultacortadesaldodecuentaResponse" location="../Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaCortaSaldoCuentaResponse" location="../Resources/consultasGeneralesCuentasTypes.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultasType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/ConsultasCuenta/ConsultaCortaSaldoCuenta/consultaCortaSaldoCuentaOut/";

declare function xf:consultaCortaSaldoCuentaOut($consultacortadesaldodecuentaResponse as element(ns0:ConsultacortadesaldodecuentaResponse))
    as element(ns1:consultaCortaSaldoCuentaResponse) {
        <ns1:consultaCortaSaldoCuentaResponse>
            {
                for $ID in $consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/ID
                return
                    <ACCOUNT_NUMBER>{ data($ID) }</ACCOUNT_NUMBER>
            }
            {
                for $ACCOUNTNAME in $consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/ACCOUNTNAME
                return
                    <ACCOUNT_NAME>{ data($ACCOUNTNAME) }</ACCOUNT_NAME>
            }
            {
                for $CURRENCY in $consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/CURRENCY
                return
                    <CURRENCY>{ data($CURRENCY) }</CURRENCY>
            }
            {
                for $INACTIVEMARKER in $consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/INACTIVEMARKER
                return
                    <INACTIVE_MARKER>{ data($INACTIVEMARKER) }</INACTIVE_MARKER>
            }
            {
                for $RESTRICTIONS in $consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/RESTRICTIONS
                return
                    <RESTRICTIONS>{ data($RESTRICTIONS) }</RESTRICTIONS>
            }
            {
            	for $ACCTBALANCES in $consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType
            	return
	                let $WORKINGBALANCE := fn:string($consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/WORKINGBALANCE/text())
	                let $LOCKEDBALANCE := fn:string($consultacortadesaldodecuentaResponse/WSACCTAVAILBALType[1]/gWSACCTAVAILBALDetailType/mWSACCTAVAILBALDetailType[1]/LOCKEDBALANCE/text())
	                return
	                	if ($LOCKEDBALANCE != "" and $WORKINGBALANCE != "") then (
	                    	<AVAILABLE_BALANCE>{ fn-bea:format-number(fn:number($WORKINGBALANCE) - fn:number($LOCKEDBALANCE),"###0.00") }</AVAILABLE_BALANCE>,
	                    	<LOCKED_BALANCE>{ fn-bea:format-number(fn:number($LOCKEDBALANCE),"###0.00") }</LOCKED_BALANCE>
	                    ) else if ($WORKINGBALANCE != "") then (
	                    	<AVAILABLE_BALANCE>{ fn-bea:format-number(fn:number($WORKINGBALANCE),"###0.00") }</AVAILABLE_BALANCE>,
	                    	<LOCKED_BALANCE>0.00</LOCKED_BALANCE>
	                    ) else (
	                    	<AVAILABLE_BALANCE>0.00</AVAILABLE_BALANCE>,
	                    	<LOCKED_BALANCE>0.00</LOCKED_BALANCE>
	                    )
            }
        </ns1:consultaCortaSaldoCuentaResponse>
};

declare variable $consultacortadesaldodecuentaResponse as element(ns0:ConsultacortadesaldodecuentaResponse) external;

xf:consultaCortaSaldoCuentaOut($consultacortadesaldodecuentaResponse)