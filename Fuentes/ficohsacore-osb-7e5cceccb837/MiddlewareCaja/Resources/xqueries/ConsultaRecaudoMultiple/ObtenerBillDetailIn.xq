(:: pragma bea:global-element-parameter parameter="$consultaRecaudoMultipleResponse" element="ns0:consultaRecaudoMultipleResponse" location="../../xsds/ConsultaRecaudoMultiple/ConsultaRecaudoMultiple.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoMultipleTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMultiple/ObtenerBillDetailIn/";

declare function xf:ObtenerBillDetailIn($consultaRecaudoMultipleResponse as element(ns0:consultaRecaudoMultipleResponse))
    as xs:string {
    	let $encabezado := "@10@No. FACTURA@30@FECHA VENC.@51@MONTO"
    	let $detalle :=
    		for $record in $consultaRecaudoMultipleResponse/BILLS/BILL_RECORD
    			return
    				concat("!@10@",fn:string($record/BILL_NUMBER/text()),
    					"@30@",fn:string($record/DUE_DATE/text()),
    					"@50@",fn:string($record/BILL_CURRENCY/text()),
    					" ",fn:string($record/TOTAL_AMOUNT/text()))
    					
        return concat($encabezado, fn:string-join($detalle,""))
};

declare variable $consultaRecaudoMultipleResponse as element(ns0:consultaRecaudoMultipleResponse) external;

xf:ObtenerBillDetailIn($consultaRecaudoMultipleResponse)