xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoChequeGerenciaLCYResponse1" element="ns0:DepositoChequeGerenciaLCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoChequeGerenciaResponse" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/depositoChequeGerenciaLcyOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeGerencia";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:depositoChequeGerenciaLcyOut($depositoChequeGerenciaLCYResponse1 as element(ns0:DepositoChequeGerenciaLCYResponse),
    $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:depositoChequeGerenciaResponse) {
        if (fn:string($depositoChequeGerenciaLCYResponse1/Status/successIndicator/text()) = "Success") then (
	        <ns1:depositoChequeGerenciaResponse>
	            <ns1:depositoChequeGerenciaResponseType>
	                <ns1:depositoChequeGerenciaResponseRecordType>
	                    {
	                        for $ID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID,
	                            $ALTACCTID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID
	                        return
	                            <ACCOUNT_NUMBER>{ concat($ID , $ALTACCTID) }</ACCOUNT_NUMBER>
	                    }
	                    {
	                        for $SHORTTITLE in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
	                        return
	                            <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
	                    }
	                    {
	                        for $CHEQUENUMBER in $depositoChequeGerenciaLCYResponse1/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
	                        return
	                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
	                    }
	                    {
	                        for $CURRENCY2 in $depositoChequeGerenciaLCYResponse1/TELLERType/CURRENCY2
	                        return
	                            <CURRENCY>{ data($CURRENCY2) }</CURRENCY>
	                    }
	                    {
	                        for $AMOUNTLOCAL2 in $depositoChequeGerenciaLCYResponse1/TELLERType/AMOUNTLOCAL2
	                        return
	                            <AMOUNT>{ data($AMOUNTLOCAL2) }</AMOUNT>
	                    }
	                    {
	                        let $result :=
	                            for $DATETIME in $depositoChequeGerenciaLCYResponse1/TELLERType/gDATETIME/DATETIME
	                            return
	                                <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $INPUTTER := fn:tokenize(fn:string($depositoChequeGerenciaLCYResponse1/TELLERType/gINPUTTER/INPUTTER/text()),"_")
	                        return
	                        	<INPUTTER>{ $INPUTTER[2] }</INPUTTER>
	                    }
	                    {
	                        for $LRAGENCYCODE in $depositoChequeGerenciaLCYResponse1/TELLERType/LRAGENCYCODE
	                        return
	                            <BRANCH_NAME>{ data($LRAGENCYCODE) }</BRANCH_NAME>
	                    }
	                </ns1:depositoChequeGerenciaResponseRecordType>
	            </ns1:depositoChequeGerenciaResponseType>
	        </ns1:depositoChequeGerenciaResponse>
	    ) else (
	    	<ns1:depositoChequeGerenciaResponse/>
	    )
};

declare variable $depositoChequeGerenciaLCYResponse1 as element(ns0:DepositoChequeGerenciaLCYResponse) external;
declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:depositoChequeGerenciaLcyOut($depositoChequeGerenciaLCYResponse1,
    $consultadedetallesdelacuentaResponse1)
