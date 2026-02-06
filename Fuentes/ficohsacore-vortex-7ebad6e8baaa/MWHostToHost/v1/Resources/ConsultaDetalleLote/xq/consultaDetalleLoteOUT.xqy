xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$OutputParameters" element="ns0:OutputParameters" location="../../../BusinessServices/PWS/consultaDetalleLote/xsd/consultaDetalleLote_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleLoteResponse" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleLote";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ConsultaComisionesH2H/xq/consultaComisionesH2HOUT/";

declare function xf:consultaDetalleLoteOUT($OutputParameters as element(ns0:OutputParameters))
    as element(ns1:consultaDetalleLoteResponse) {
        <ns1:consultaDetalleLoteResponse>
            <CUSTOMER_ID>{ data($OutputParameters/ns0:PV_CODIGOCLIENTE) }</CUSTOMER_ID>
            <BANK_BATCH_ID>{ data($OutputParameters/ns0:PV_CODIGOLOTE) }</BANK_BATCH_ID>
            <NUMBER_OF_CUSTOMERS>{ data($OutputParameters/ns0:PN_NUMEROCLIENTES) }</NUMBER_OF_CUSTOMERS>
            <NUMBER_OF_CUSTOMERS_SUCCESS>{ data($OutputParameters/ns0:PN_NUMEROCLIENTESCORRECTOS) }</NUMBER_OF_CUSTOMERS_SUCCESS>
            <NUMBER_OF_CUSTOMERS_ERROR>{ data($OutputParameters/ns0:PN_NUMEROCLIENTESERRORES) }</NUMBER_OF_CUSTOMERS_ERROR>
            <CUSTOMERS>{ 
	    	for $customer at $index in $OutputParameters/ns0:PT_CODIGOCLIENTEGENERADO/ns0:PT_TVARCHAR20_ITEM
		return
			<CUSTOMER>
				<ID>{ data($OutputParameters/ns0:PT_CODIGOCLIENTEGENERADO/ns0:PT_TVARCHAR20_ITEM[$index]) }</ID>
				<ACCOUNT>{ data($OutputParameters/ns0:PT_NUMEROCUENTA/ns0:PT_TVARCHAR20_ITEM[$index]) }</ACCOUNT>
				<ACCOUNT_CURRENCY>{ data($OutputParameters/ns0:PT_MONEDACUENTA/ns0:PT_TVARCHAR3_ITEM[$index]) }</ACCOUNT_CURRENCY>
				<LEGAL_ID>{ data($OutputParameters/ns0:PT_IDENTIFICACION/ns0:PT_TVARCHAR13_ITEM[$index]) }</LEGAL_ID>
				<ACCOUNT_NAME>{ data($OutputParameters/ns0:PT_NOMBRECUENTA/ns0:PT_TVARCHAR80_ITEM[$index]) }</ACCOUNT_NAME>
				<STATUS>{ data($OutputParameters/ns0:PT_ESTADO/ns0:PT_TVARCHAR20_ITEM[$index]) }</STATUS>
				<ERROR_DESCRIPTION>{ data($OutputParameters/ns0:PT_DESCRIPCIONERROR/ns0:PT_TVARCHAR200_ITEM[$index]) }</ERROR_DESCRIPTION>
			</CUSTOMER>
	    }</CUSTOMERS>
        </ns1:consultaDetalleLoteResponse>
};

declare variable $OutputParameters as element(ns0:OutputParameters) external;

xf:consultaDetalleLoteOUT($OutputParameters)