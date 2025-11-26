(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaResponse1" element="ns0:ConsultadechequedegerenciaResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoChequeGerenciaResponse" location="../../xsds/ConsultaEstadoChequeGerencia/ConsultaEstadoChequeGerencia.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeGerencia/consultaChequeGerenciaLcyOut/";

declare function xf:consultaChequeGerenciaLcyOut($consultadechequedegerenciaResponse1 as element(ns0:ConsultadechequedegerenciaResponse))
    as element(ns1:consultaEstadoChequeGerenciaResponse) {
    	if (fn:string($consultadechequedegerenciaResponse1/Status/successIndicator/text()) = "Success" and
            fn:string($consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/ZERORECORDS/text()) = "") then (
	        <ns1:consultaEstadoChequeGerenciaResponse>
	            <ns1:consultaEstadoChequeGerenciaResponseType>
	                <ns1:consultaEstadoChequeGerenciaResponseRecordType>
	                    {
	                        for $CHEQUENUMBER in $consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/gWSFICOECASHIERCHEQUEDETAILSDetailType/mWSFICOECASHIERCHEQUEDETAILSDetailType[1]/CHEQUENUMBER
	                        return
	                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
	                    }
	                    {
	                        for $CURRENCY in $consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/gWSFICOECASHIERCHEQUEDETAILSDetailType/mWSFICOECASHIERCHEQUEDETAILSDetailType[1]/CURRENCY
	                        return
	                            <CURRENCY>{ data($CURRENCY) }</CURRENCY>
	                    }
	                    {
	                        for $BENEFICIARYNAME in $consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/gWSFICOECASHIERCHEQUEDETAILSDetailType/mWSFICOECASHIERCHEQUEDETAILSDetailType[1]/BENEFICIARYNAME
	                        return
	                            <BENEFICIARY_NAME>{ data($BENEFICIARYNAME) }</BENEFICIARY_NAME>
	                    }
	                    {
	                        for $AMOUNT in $consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/gWSFICOECASHIERCHEQUEDETAILSDetailType/mWSFICOECASHIERCHEQUEDETAILSDetailType[1]/AMOUNT
	                        return
	                            <AMOUNT>{ data($AMOUNT) }</AMOUNT>
	                    }
	                    {
	                        for $CHEQUESTATUS in $consultadechequedegerenciaResponse1/WSFICOECASHIERCHEQUEDETAILSType[1]/gWSFICOECASHIERCHEQUEDETAILSDetailType/mWSFICOECASHIERCHEQUEDETAILSDetailType[1]/CHEQUESTATUS
	                        return
	                            <STATUS>{ data($CHEQUESTATUS) }</STATUS>
	                    }
	                </ns1:consultaEstadoChequeGerenciaResponseRecordType>
	            </ns1:consultaEstadoChequeGerenciaResponseType>
	        </ns1:consultaEstadoChequeGerenciaResponse>
	    ) else (
	    	<ns1:consultaEstadoChequeGerenciaResponse/>
	    )
};

declare variable $consultadechequedegerenciaResponse1 as element(ns0:ConsultadechequedegerenciaResponse) external;

xf:consultaChequeGerenciaLcyOut($consultadechequedegerenciaResponse1)