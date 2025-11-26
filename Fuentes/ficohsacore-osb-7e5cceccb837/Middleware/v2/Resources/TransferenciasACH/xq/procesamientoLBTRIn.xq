(:: pragma bea:global-element-parameter parameter="$transferenciasACHRequest" element="ns0:transferenciasACHRequest" location="../xsd/transferenciasACHType.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaDatosACHEnviadoResponse" element="ns1:ConsultaDatosACHEnviadoResponse" location="../../../BusinessServices/ACH/Enviado/SvcACHEnviado/xsd/XMLSchema_-1255526967.xsd" ::)
(:: pragma bea:global-element-return element="ns2:InputParameters" location="../../../BusinessServices/LBTR/ProcesamientoLBTR/xsd/ProcesamientoLBTR_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/transferenciasACHType";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ProcesamientoLBTR";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/TransferenciasACH/xq/procesamientoLBTRIn/";

declare function xf:procesamientoLBTRIn($transferenciasACHRequest as element(ns0:transferenciasACHRequest),
    $consultaDatosACHEnviadoResponse as element(ns1:ConsultaDatosACHEnviadoResponse))
    as element(ns2:InputParameters) {
        <ns2:InputParameters>
            <ns2:PN_CODIGO_BANCO>{ data($transferenciasACHRequest/DESTINATION_BANK) }</ns2:PN_CODIGO_BANCO>
            <ns2:PV_NUMERO_REFERENCIA>{ data($transferenciasACHRequest/INTERFACE_REFERENCE_NO) }</ns2:PV_NUMERO_REFERENCIA>
            <ns2:PD_FECHA_ADICION>{ fn:current-dateTime() }</ns2:PD_FECHA_ADICION>
            <ns2:PN_CORRELATIVO_ARCHIVO>{ xs:decimal(93) }</ns2:PN_CORRELATIVO_ARCHIVO>
            <ns2:PN_SECUENCIA_REGISTRO>{ xs:decimal(23) }</ns2:PN_SECUENCIA_REGISTRO>
            <ns2:PV_TIPO_PERSONA>N</ns2:PV_TIPO_PERSONA>
            {
                for $LEGALHOLDERNAME in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/LEGALHOLDERNAME,
                    $CUSHORTTITLE in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/CUSHORTTITLE
                return
                    <ns2:PV_NOMBRE_ORDENANTE>
                        {
                            if ($LEGALHOLDERNAME != '') then
                                data($LEGALHOLDERNAME)
                            else( 
                                data($CUSHORTTITLE)
                            )
                        }
					</ns2:PV_NOMBRE_ORDENANTE>
            }
            <ns2:PV_NUMERO_CUENTA_ORDENANTE>{ data($transferenciasACHRequest/LOCAL_ORIGINAL_ACCOUNT) }</ns2:PV_NUMERO_CUENTA_ORDENANTE>
            {
                for $LEGALID in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/LEGALID
                return
                    <ns2:PV_NUMERO_IDENTIFICACION_O>{ data($LEGALID) }</ns2:PV_NUMERO_IDENTIFICACION_O>
            }
            <ns2:PN_TIPO_CUENTA_ORDENANTE>
                {
                    if (data($transferenciasACHRequest/ACCOUNT_TYPE) = 'Savings') then (
                    	xs:decimal(1)
                    )else if (data($transferenciasACHRequest/ACCOUNT_TYPE) = 'Checking') then(
                    	xs:decimal(2)
                    )else if (data($transferenciasACHRequest/ACCOUNT_TYPE) = 'Loan') then (
                    	xs:decimal(3)
                    )else( 
                    	xs:decimal(99)
                    )
                }
			</ns2:PN_TIPO_CUENTA_ORDENANTE>
            {
                for $ADDRESSLINE1 in $consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/ADDRESSLINE1
                return
                    <ns2:PV_DIRECCION_ORDENANTE>{ data($ADDRESSLINE1) }</ns2:PV_DIRECCION_ORDENANTE>
            }
            <ns2:PV_NOMBRE_BENEFICIARIO>{ data($transferenciasACHRequest/BENEFICIARY_NAME) }</ns2:PV_NOMBRE_BENEFICIARIO>
            <ns2:PV_NUMERO_CUENTA_BENEFICIARIO>{ data($transferenciasACHRequest/CREDIT_ACCOUNT) }</ns2:PV_NUMERO_CUENTA_BENEFICIARIO>
            <ns2:PV_NUMERO_IDENTIFICACION_B>9999999999999</ns2:PV_NUMERO_IDENTIFICACION_B>
            <ns2:PV_DIRECCION_BENEFICIARIO>TEGUCIGALPA HONDURAS</ns2:PV_DIRECCION_BENEFICIARIO>
            <ns2:PV_TIPO_CUENTA_BENEFICIARIO>
                {
                    if (data($transferenciasACHRequest/ACCOUNT_TYPE) = 'Savings') then(
                        xs:decimal(1)
                    )else if (data($transferenciasACHRequest/ACCOUNT_TYPE) = 'Checking') then(
                        xs:decimal(2)
                    )else if (data($transferenciasACHRequest/ACCOUNT_TYPE) = 'Loan') then(
                    	xs:decimal(3)
                    )else( 
						xs:decimal(99)
					)
                }
			</ns2:PV_TIPO_CUENTA_BENEFICIARIO>
            <ns2:PV_CODIGO_MONEDA>{ data($transferenciasACHRequest/CREDIT_CURRENCY) }</ns2:PV_CODIGO_MONEDA>
            <ns2:PN_VALOR_TRANSACCION>{ data($transferenciasACHRequest/TRANSFER_AMOUNT) }</ns2:PN_VALOR_TRANSACCION>
            <ns2:PV_ESTADO>A</ns2:PV_ESTADO>
            <ns2:PV_NOMBRE_ARCHIVO_LBTR>Generate.txt</ns2:PV_NOMBRE_ARCHIVO_LBTR>
            <ns2:PD_FECHA_HORA>{ fn:current-dateTime() }</ns2:PD_FECHA_HORA>
            <ns2:PN_CODIGO_CLIENTE>{ data($consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/CUSTOMERID) }</ns2:PN_CODIGO_CLIENTE>
            <ns2:PD_FECHA_DEVOLUCION>{ xs:dateTime('1900-01-01T00:00:00') }</ns2:PD_FECHA_DEVOLUCION>
            <ns2:PV_DETALLE_TRANSACCION>{ data($transferenciasACHRequest/TRANSACTION_DESCRIPTION) }</ns2:PV_DETALLE_TRANSACCION>
            <ns2:PN_ORIGEN_CATEGORIA>
                {
                    if (data($consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/DEBITACCOUNTTYPE) = 'Ahorros') then(
                    	xs:decimal(1)
                    )else if (data($consultaDatosACHEnviadoResponse/WSACHOUTGOINGType[1]/gWSACHOUTGOINGDetailType/mWSACHOUTGOINGDetailType[1]/DEBITACCOUNTTYPE) = 'Cheques') then(
                    	xs:decimal(2)
                    )else( 
                    	xs:decimal(0)
                    )
                }
			</ns2:PN_ORIGEN_CATEGORIA>
        </ns2:InputParameters>
};

declare variable $transferenciasACHRequest as element(ns0:transferenciasACHRequest) external;
declare variable $consultaDatosACHEnviadoResponse as element(ns1:ConsultaDatosACHEnviadoResponse) external;

xf:procesamientoLBTRIn($transferenciasACHRequest,
    $consultaDatosACHEnviadoResponse)