xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$depositoChequeGerenciaFCYResponse1" element="ns0:DepositoChequeGerenciaFCYResponse" location="../../xsds/TransaccionesAutobancos/XMLSchema_1271081668.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$cambioestadochqgerenciaFCYResponse1" element="ns0:CambioestadochqgerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultadedetallesdelacuentaResponse1" element="ns0:ConsultadedetallesdelacuentaResponse" location="../../xsds/ConsultasCuenta/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-return element="ns1:depositoChequeGerenciaResponse" location="../../xsds/DepositoChequeGerencia/DepositoChequeGerencia.xsd" ::)

declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/DepositoChequeGerencia/depositoChequeGerenciaFcyOut/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/depositoChequeGerencia";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:depositoChequeGerenciaFcyOut($depositoChequeGerenciaFCYResponse1 as element(ns0:DepositoChequeGerenciaFCYResponse),
    $cambioestadochqgerenciaFCYResponse1 as element(ns0:CambioestadochqgerenciaFCYResponse),
    $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse))
    as element(ns1:depositoChequeGerenciaResponse) {
        if (fn:string($depositoChequeGerenciaFCYResponse1/Status/successIndicator/text()) = "Success" and 
    		fn:string($cambioestadochqgerenciaFCYResponse1/Status/successIndicator/text()) = "Success" ) then (
	        <ns1:depositoChequeGerenciaResponse>
	            <ns1:depositoChequeGerenciaResponseType>
	                <ns1:depositoChequeGerenciaResponseRecordType>
	                    {
	                        for $ID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ID,
	                            $ALTACCTID in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/ALTACCTID
	                        return
	                            <ACCOUNT_NUMBER>{ concat($ID , "/", $ALTACCTID) }</ACCOUNT_NUMBER>
	                    }
	                    {
	                        for $SHORTTITLE in $consultadedetallesdelacuentaResponse1/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/SHORTTITLE
	                        return
	                            <ACCOUNT_NAME>{ data($SHORTTITLE) }</ACCOUNT_NAME>
	                    }
	                    {
	                        for $CHEQUENUMBER in $depositoChequeGerenciaFCYResponse1/TELLERType/gCHEQUENUMBER/mCHEQUENUMBER[1]/CHEQUENUMBER
	                        return
	                            <CHEQUE_NUMBER>{ data($CHEQUENUMBER) }</CHEQUE_NUMBER>
	                    }
	                    {
	                        for $CURRENCY2 in $depositoChequeGerenciaFCYResponse1/TELLERType/CURRENCY2
	                        return
	                            <CURRENCY>{ data($CURRENCY2) }</CURRENCY>
	                    }
	                    {
	                        for $AMOUNTFCY2 in $depositoChequeGerenciaFCYResponse1/TELLERType/AMOUNTFCY2
	                        return
	                            <AMOUNT>{ data($AMOUNTFCY2) }</AMOUNT>
	                    }
	                    {
	                        let $result :=
	                            for $DATETIME in $depositoChequeGerenciaFCYResponse1/TELLERType/gDATETIME/DATETIME
	                            return
	                                <DATE_TIME>{ fn:concat("20",data($DATETIME)) }</DATE_TIME>
	                        return
	                            $result[1]
	                    }
	                    {
	                        let $INPUTTER := fn:tokenize(fn:string($depositoChequeGerenciaFCYResponse1/TELLERType/gINPUTTER/INPUTTER/text()),"_")
                            return
                                <INPUTTER>{ $INPUTTER[2] }</INPUTTER>
	                    }
	                    {
	                        for $LRAGENCYCODE in $depositoChequeGerenciaFCYResponse1/TELLERType/LRAGENCYCODE
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

declare variable $depositoChequeGerenciaFCYResponse1 as element(ns0:DepositoChequeGerenciaFCYResponse) external;
declare variable $cambioestadochqgerenciaFCYResponse1 as element(ns0:CambioestadochqgerenciaFCYResponse) external;
declare variable $consultadedetallesdelacuentaResponse1 as element(ns0:ConsultadedetallesdelacuentaResponse) external;

xf:depositoChequeGerenciaFcyOut($depositoChequeGerenciaFCYResponse1,
    $cambioestadochqgerenciaFCYResponse1,
    $consultadedetallesdelacuentaResponse1)
