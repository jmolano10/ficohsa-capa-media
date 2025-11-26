(:: pragma bea:global-element-parameter parameter="$consultadechequedegerenciaFCYResponse1" element="ns0:ConsultadechequedegerenciaFCYResponse" location="../../xsds/ChequeGerencia/XMLSchema_-1805424041.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaEstadoChequeGerenciaResponse" location="../../xsds/ConsultaEstadoChequeGerencia/ConsultaEstadoChequeGerencia.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoChequeGerenciaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaEstadoChequeGerencia/consultaChequeGerenciaFcyOut/";

declare function xf:consultaChequeGerenciaFcyOut($consultadechequedegerenciaFCYResponse1 as element(ns0:ConsultadechequedegerenciaFCYResponse))
    as element(ns1:consultaEstadoChequeGerenciaResponse) {
        if (fn:string($consultadechequedegerenciaFCYResponse1/Status/successIndicator/text()) = "Success" and
        	fn:string($consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/ZERORECORDS/text()) = "") then (    	
	        <ns1:consultaEstadoChequeGerenciaResponse>
	            <ns1:consultaEstadoChequeGerenciaResponseType>
	                <ns1:consultaEstadoChequeGerenciaResponseRecordType>
	                    {
	                        for $Cheque in $consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Cheque
	                        return
	                            <CHEQUE_NUMBER>{ data($Cheque) }</CHEQUE_NUMBER>
	                    }
	                    {
	                        for $Ccy in $consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Ccy
	                        return
	                            <CURRENCY>{ data($Ccy) }</CURRENCY>
	                    }
	                    {
	                        for $Beneficiary in $consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Beneficiary
	                        return
	                            <BENEFICIARY_NAME>{ data($Beneficiary) }</BENEFICIARY_NAME>
	                    }
	                    {
	                        for $Amount in $consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Amount
	                        return
	                            <AMOUNT>{ data($Amount) }</AMOUNT>
	                    }
	                    {
	                        for $Status in $consultadechequedegerenciaFCYResponse1/FICOHNFCYDRAFTDETAILSWSType[1]/gFICOHNFCYDRAFTDETAILSWSDetailType/mFICOHNFCYDRAFTDETAILSWSDetailType[1]/Status
	                        return
	                            <STATUS>{ data($Status) }</STATUS>
	                    }
	                </ns1:consultaEstadoChequeGerenciaResponseRecordType>
	            </ns1:consultaEstadoChequeGerenciaResponseType>
	        </ns1:consultaEstadoChequeGerenciaResponse>
	    ) else (
	    	<ns1:consultaEstadoChequeGerenciaResponse/>
	    )
};

declare variable $consultadechequedegerenciaFCYResponse1 as element(ns0:ConsultadechequedegerenciaFCYResponse) external;

xf:consultaChequeGerenciaFcyOut($consultadechequedegerenciaFCYResponse1)