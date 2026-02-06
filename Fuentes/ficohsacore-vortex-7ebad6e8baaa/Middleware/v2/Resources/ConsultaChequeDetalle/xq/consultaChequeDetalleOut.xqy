xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/ABKGT/chequeDetalle/xsd/chequeDetalle_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaChequeDetalleResponse" location="../../ConsultaChequesCompensacion/xsd/consultaChequesCompensacionTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaChequeDetalle/xq/consultaChequeDetalleOut/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/chequeDetalle";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaChequesCompensacionTypes";


declare function xf:consultaChequeDetalleOut($outputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaChequeDetalleResponse) {
        <ns1:consultaChequeDetalleResponse>
        	{
        		let $date           := $outputParameters/ns0:PD_FECHA
        		let $branches 	    := $outputParameters/ns0:PT_CODIGO_AGENCIA/ns0:ITEM
        		let $journals 	    := $outputParameters/ns0:PT_JORNADA/ns0:ITEM
        		let $types 		    := $outputParameters/ns0:PT_TIPO/ns0:ITEM
        		let $currencies     := $outputParameters/ns0:PT_CODIGO_MONEDA/ns0:ITEM
        		let $banks 		    := $outputParameters/ns0:PT_CODIGO_BANCO/ns0:ITEM
        		let $tellers 	    := $outputParameters/ns0:PT_CODIGO_USUARIO/ns0:ITEM
        		let $accounts 	    := $outputParameters/ns0:PT_CUENTA/ns0:ITEM
        		let $checks 	    := $outputParameters/ns0:PT_NUMERO_CHEQUE/ns0:ITEM
        		let $amounts 	    := $outputParameters/ns0:PT_MONTO/ns0:ITEM
        		let $identifiers    := $outputParameters/ns0:PT_MARCA_CAJA/ns0:ITEM
        		let $checksCounting := fn:count($checks)
        		let $dateFormat     := "yyyy-MM-dd"
        		let $dateAsString   := fn:string(fn-bea:date-from-string-with-format($dateFormat, fn:string(data($date))))
        		return
        		if ($checksCounting > 0) then (
        			<CHECKS>
        				{
        					for $index in (1 to $checksCounting)
        						return
        						<CHECK>
        							<BRANCH>{ data($branches[$index]) }</BRANCH>
        							<JOURNAL>{ data($journals[$index]) }</JOURNAL>       						
        							<TYPE>{ data($types[$index]) }</TYPE>       						
        							<CURRENCY>{ data($currencies[$index]) }</CURRENCY>       						
        							<DATE>{ $dateAsString }</DATE>
        							<BANK_CODE>{ data($banks[$index]) }</BANK_CODE>
        							<ACCOUNT>{ data($accounts[$index]) }</ACCOUNT>
        							<CHECK_NUMBER>{ data($checks[$index]) }</CHECK_NUMBER>
        							<AMOUNT>{ data($amounts[$index]) }</AMOUNT>
        							<UNIQUE_ID>{ data($identifiers[$index]) }</UNIQUE_ID>
        							<TELLER>{ data($tellers[$index]) }</TELLER>
        						</CHECK>
        				}	
        			</CHECKS>
        		) else ()
        	}
        </ns1:consultaChequeDetalleResponse>
};

declare variable $outputParameters as element(ns0:OutputParameters) external;

xf:consultaChequeDetalleOut($outputParameters)