xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:local-element-parameter parameter="$wSCUSTOMERType1" type="ns0:ConsultadeclienteResponse/WSCUSTOMERType" location="../../../../Business_Resources/consultasCliente/Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma bea:local-element-parameter parameter="$wSACCOUNTLISTType1" type="ns0:ConsultadedetallesdelacuentaResponse/WSACCOUNTLISTType" location="../../../../Business_Resources/ConsultasCuenta/Resources/XMLSchema_378991004.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest1" element="ns2:transferenciasACHRequest" location="../../../../Business_Resources/Transferencias/TransferenciasACH/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/LBTR/ProcesamientoLBTR/xsd/ProcesamientoLBTR_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/ProcesarEnviosLBTRIn/";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ProcesamientoLBTR";
declare namespace ns0 = "T24WebServicesImpl";

declare function xf:ProcesarEnviosLBTRIn($wSCUSTOMERType1 as element(),
    $wSACCOUNTLISTType1 as element(),
    $transferenciasACHRequest1 as element(ns2:transferenciasACHRequest),
    $OrigenCategoria as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CODIGO_BANCO>{ data($transferenciasACHRequest1/DESTINATION_BANK) }</ns1:PN_CODIGO_BANCO>
            <ns1:PV_NUMERO_REFERENCIA>{ data($transferenciasACHRequest1/INTERFACE_REFERENCE_NO) }</ns1:PV_NUMERO_REFERENCIA>
            <ns1:PD_FECHA_ADICION>{ fn:current-dateTime() }</ns1:PD_FECHA_ADICION>
            <ns1:PN_CORRELATIVO_ARCHIVO>93</ns1:PN_CORRELATIVO_ARCHIVO>
            <ns1:PN_SECUENCIA_REGISTRO>23</ns1:PN_SECUENCIA_REGISTRO>
            <ns1:PV_TIPO_PERSONA>N</ns1:PV_TIPO_PERSONA>
            <ns1:PV_NOMBRE_ORDENANTE>
            {
                let $LEGALHOLDERNAME := fn:string($wSCUSTOMERType1/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALHOLDERNAME/text())
                let $SHORTNAME := fn:string($wSCUSTOMERType1/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/SHORTNAME/text())
                return
                	if ($LEGALHOLDERNAME != "" ) then (
                		$LEGALHOLDERNAME
                	) else (
                		$SHORTNAME
                	)
            }
            </ns1:PV_NOMBRE_ORDENANTE>
            <ns1:PV_NUMERO_CUENTA_ORDENANTE>
            { 
                if(data($transferenciasACHRequest1/LOCAL_ACCOUNT_TYPE) = "INDIRECT" ) then
                	data($transferenciasACHRequest1/LOCAL_ORIGINAL_ACCOUNT)
                else
                	data($transferenciasACHRequest1/DEBIT_ACCOUNT)
            }
            </ns1:PV_NUMERO_CUENTA_ORDENANTE>
            {
                for $LEGALID in $wSCUSTOMERType1/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID
                return
                    <ns1:PV_NUMERO_IDENTIFICACION_O>{ data($LEGALID) }</ns1:PV_NUMERO_IDENTIFICACION_O>
            }
            <ns1:PN_TIPO_CUENTA_ORDENANTE>
                {
                    fn:string(if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Savings") then
                    (
                    2
                    )
                    else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Checking") then
                    (
                    1
                    )
                    else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = "Loan") then
                    (
                    3
                    )
                    else
                    (
                    99
                    ))
                }
			</ns1:PN_TIPO_CUENTA_ORDENANTE>
            {
                for $ADDRESSLINE1 in $wSCUSTOMERType1/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/ADDRESSLINE1
                return
                    <ns1:PV_DIRECCION_ORDENANTE>{ data($ADDRESSLINE1) }</ns1:PV_DIRECCION_ORDENANTE>
            }
            <ns1:PV_NOMBRE_BENEFICIARIO>{ data($transferenciasACHRequest1/BENEFICIARY_NAME) }</ns1:PV_NOMBRE_BENEFICIARIO>
            <ns1:PV_NUMERO_CUENTA_BENEFICIARIO>{ data($transferenciasACHRequest1/CREDIT_ACCOUNT) }</ns1:PV_NUMERO_CUENTA_BENEFICIARIO>
            <ns1:PV_NUMERO_IDENTIFICACION_B>9999999999999</ns1:PV_NUMERO_IDENTIFICACION_B>
            <ns1:PV_DIRECCION_BENEFICIARIO>TEGUCIGALPA HONDURAS</ns1:PV_DIRECCION_BENEFICIARIO>
            <ns1:PV_TIPO_CUENTA_BENEFICIARIO>
                {
                    fn:string
                    (
	                    if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = 'Savings') then
	                    (
	                    	1
	                    )
	                    else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = 'Checking') then 
	                    (
	                    	2
	                    )
	                    else if (fn:string($transferenciasACHRequest1/ACCOUNT_TYPE/text()) = 'Loan') then
	                    (
	                    	3
	                    )
	                    else
	                    (
	                    	99
	                    )
                    )
                }
			</ns1:PV_TIPO_CUENTA_BENEFICIARIO>
            <ns1:PV_CODIGO_MONEDA>{ data($transferenciasACHRequest1/CREDIT_CURRENCY) }</ns1:PV_CODIGO_MONEDA>
            <ns1:PN_VALOR_TRANSACCION>{ data($transferenciasACHRequest1/TRANSFER_AMOUNT) }</ns1:PN_VALOR_TRANSACCION>
            <ns1:PV_ESTADO>A</ns1:PV_ESTADO>
            <ns1:PV_NOMBRE_ARCHIVO_LBTR>Generate.txt</ns1:PV_NOMBRE_ARCHIVO_LBTR>
            <ns1:PD_FECHA_HORA>{ fn:current-dateTime() }</ns1:PD_FECHA_HORA>
            {
                for $CUSTOMERNUMBER in $wSACCOUNTLISTType1/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType[1]/CUSTOMERNUMBER
                return
                    <ns1:PN_CODIGO_CLIENTE>{ data($CUSTOMERNUMBER) }</ns1:PN_CODIGO_CLIENTE>
            }
            <ns1:PD_FECHA_DEVOLUCION>1900-01-01</ns1:PD_FECHA_DEVOLUCION>
            <ns1:PV_DETALLE_TRANSACCION>{ data($transferenciasACHRequest1/TRANSACTION_DESCRIPTION) }</ns1:PV_DETALLE_TRANSACCION>
            <ns1:PN_ORIGEN_CATEGORIA>{ $OrigenCategoria }</ns1:PN_ORIGEN_CATEGORIA>
        </ns1:InputParameters>
};

declare variable $wSCUSTOMERType1 as element() external;
declare variable $wSACCOUNTLISTType1 as element() external;
declare variable $transferenciasACHRequest1 as element(ns2:transferenciasACHRequest) external;
declare variable $OrigenCategoria as xs:string external;

xf:ProcesarEnviosLBTRIn($wSCUSTOMERType1,
    $wSACCOUNTLISTType1,
    $transferenciasACHRequest1,
    $OrigenCategoria)