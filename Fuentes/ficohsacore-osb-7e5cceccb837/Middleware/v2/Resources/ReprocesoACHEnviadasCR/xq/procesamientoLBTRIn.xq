(:: pragma bea:global-element-parameter parameter="$reprocesoACHEnviadasCR" element="ns0:reprocesoACHEnviadasCR" location="../xsd/reprocesoACHEnviadasCRTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/LBTR/ProcesamientoLBTR/xsd/ProcesamientoLBTR_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/reprocesoACHEnviadasCRTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ProcesamientoLBTR";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReprocesoACHEnviadasCR/xq/procesamientoLBTRIn/";

declare function xf:procesamientoLBTRIn($reprocesoACHEnviadasCR as element(ns0:reprocesoACHEnviadasCR))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PN_CODIGO_BANCO>{ data($reprocesoACHEnviadasCR/DESTINATION_BANK) }</ns1:PN_CODIGO_BANCO>
            {
                for $INTERFACE_REFERENCE_NO in $reprocesoACHEnviadasCR/INTERFACE_REFERENCE_NO
                return
                    <ns1:PV_NUMERO_REFERENCIA>{ data($INTERFACE_REFERENCE_NO) }</ns1:PV_NUMERO_REFERENCIA>
            }
            <ns1:PD_FECHA_ADICION>{ current-dateTime() }</ns1:PD_FECHA_ADICION>
            <ns1:PN_CORRELATIVO_ARCHIVO>93</ns1:PN_CORRELATIVO_ARCHIVO>
            <ns1:PN_SECUENCIA_REGISTRO>23</ns1:PN_SECUENCIA_REGISTRO>
            <ns1:PV_TIPO_PERSONA>N</ns1:PV_TIPO_PERSONA>
            {
                for $ORD_NAME in $reprocesoACHEnviadasCR/ORD_NAME
                return
                    <ns1:PV_NOMBRE_ORDENANTE>{ data($ORD_NAME) }</ns1:PV_NOMBRE_ORDENANTE>
            }
            {
                for $ORD_ORIGINAL_ACCOUNT in $reprocesoACHEnviadasCR/ORD_ORIGINAL_ACCOUNT
                return
                    <ns1:PV_NUMERO_CUENTA_ORDENANTE>{ data($ORD_ORIGINAL_ACCOUNT) }</ns1:PV_NUMERO_CUENTA_ORDENANTE>
            }
            {
                for $ORD_IDENTIFICATION in $reprocesoACHEnviadasCR/ORD_IDENTIFICATION
                return
                    <ns1:PV_NUMERO_IDENTIFICACION_O>{ data($ORD_IDENTIFICATION) }</ns1:PV_NUMERO_IDENTIFICACION_O>
            }
            <ns1:PN_TIPO_CUENTA_ORDENANTE>
            	{ 
                    if (data($reprocesoACHEnviadasCR/ACCOUNT_TYPE)  = 'Savings') then (
                    	xs:decimal(2)
                    )else if (data($reprocesoACHEnviadasCR/ACCOUNT_TYPE)  = 'Checking') then(
                    	xs:decimal(1)
                    )else if (data($reprocesoACHEnviadasCR/ACCOUNT_TYPE)  = 'Loan') then (
                    	xs:decimal(3)
                    )else( 
                    	xs:decimal(99)
                    )
            	}
            </ns1:PN_TIPO_CUENTA_ORDENANTE>
            {
                for $ORD_CUSTOMER_DIRECTION in $reprocesoACHEnviadasCR/ORD_CUSTOMER_DIRECTION
                return
                    <ns1:PV_DIRECCION_ORDENANTE>{ data($ORD_CUSTOMER_DIRECTION) }</ns1:PV_DIRECCION_ORDENANTE>
            }
            {
                for $BEN_NAME in $reprocesoACHEnviadasCR/BEN_NAME
                return
                    <ns1:PV_NOMBRE_BENEFICIARIO>{ data($BEN_NAME) }</ns1:PV_NOMBRE_BENEFICIARIO>
            }
            {
                for $BEN_ACCOUNT in $reprocesoACHEnviadasCR/BEN_ACCOUNT
                return
                    <ns1:PV_NUMERO_CUENTA_BENEFICIARIO>{ data($BEN_ACCOUNT) }</ns1:PV_NUMERO_CUENTA_BENEFICIARIO>
            }
            <ns1:PV_NUMERO_IDENTIFICACION_B>9999999999999</ns1:PV_NUMERO_IDENTIFICACION_B>
            <ns1:PV_DIRECCION_BENEFICIARIO>TEGUCIGALPA HONDURAS</ns1:PV_DIRECCION_BENEFICIARIO>
            {
                for $ACCOUNT_TYPE in $reprocesoACHEnviadasCR/ACCOUNT_TYPE
                return
                    <ns1:PV_TIPO_CUENTA_BENEFICIARIO>
                    	{
		                    if (data($ACCOUNT_TYPE)  = 'Savings') then(
		                        xs:decimal(2)
		                    )else if (data($ACCOUNT_TYPE)  = 'Checking') then(
		                        xs:decimal(1)
		                    )else if (data($ACCOUNT_TYPE)  = 'Loan') then(
		                    	xs:decimal(3)
		                    )else( 
								xs:decimal(99)
							)
		                }
                    </ns1:PV_TIPO_CUENTA_BENEFICIARIO>
            }
            {
                for $BEN_CURRENCY in $reprocesoACHEnviadasCR/BEN_CURRENCY
                return
                    <ns1:PV_CODIGO_MONEDA>{ data($BEN_CURRENCY) }</ns1:PV_CODIGO_MONEDA>
            }
            {
                for $BEN_AMOUNT in $reprocesoACHEnviadasCR/BEN_AMOUNT
                return
                    <ns1:PN_VALOR_TRANSACCION>{ data($BEN_AMOUNT) }</ns1:PN_VALOR_TRANSACCION>
            }
            <ns1:PV_ESTADO>A</ns1:PV_ESTADO>
            <ns1:PV_NOMBRE_ARCHIVO_LBTR>Generate.txt</ns1:PV_NOMBRE_ARCHIVO_LBTR>
            <ns1:PD_FECHA_HORA>{ current-dateTime() }</ns1:PD_FECHA_HORA>
            <ns1:PN_CODIGO_CLIENTE>{ data($reprocesoACHEnviadasCR/T24_CUSTOMER_ID) }</ns1:PN_CODIGO_CLIENTE>
            <ns1:PD_FECHA_DEVOLUCION>{ xs:dateTime('1900-01-01T00:00:00') }</ns1:PD_FECHA_DEVOLUCION>
            {
                for $TXN_DETAIL in $reprocesoACHEnviadasCR/TXN_DETAIL
                return
                    <ns1:PV_DETALLE_TRANSACCION>{ data($TXN_DETAIL) }</ns1:PV_DETALLE_TRANSACCION>
            }
            <ns1:PN_ORIGEN_CATEGORIA>
            	{
                    if (data($reprocesoACHEnviadasCR/ORD_ACCOUNT_TYPE) = 'Ahorros') then(
                    	xs:decimal(1)
                    )else if (data($reprocesoACHEnviadasCR/ORD_ACCOUNT_TYPE) = 'Cheques') then(
                    	xs:decimal(2)
                    )else( 
                    	xs:decimal(0)
                    )
                }
            </ns1:PN_ORIGEN_CATEGORIA>
        </ns1:InputParameters>
};

declare variable $reprocesoACHEnviadasCR as element(ns0:reprocesoACHEnviadasCR) external;

xf:procesamientoLBTRIn($reprocesoACHEnviadasCR)
