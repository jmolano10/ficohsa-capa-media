(:: pragma bea:global-element-parameter parameter="$prestamosResponse" element="ns2:OutputParameters" location="../Resources/ConsultaListaPrestamos/xsd/ORA_BANK_OSB_K_CONSULTALISTAPRESTAMOS_TOPLEVEL-24OSB_CON_LISTA_PRESTA.xsd" ::)
(:: pragma  parameter="$PrestamoAdicResponse" type="anyType" ::)
(:: pragma bea:global-element-parameter parameter="$tarjetasCreditoResponse" element="ns0:TarjetasdecreditoporclienteResponse" location="../Resources/XMLSchema_1144838292.xsd" ::)
(:: pragma  parameter="$tarjetaCreditoAdicResponse" type="anyType" ::)
(:: pragma bea:global-element-return element="ns1:consultaPasivosClienteResponse" location="../Resources/consultaClientesTypes.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_K_CONSULTALISTAPRESTAMOS/TOPLEVEL-24OSB_CON_LISTA_PRESTA/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPasivosClienteOut/";

declare function xf:consultaPasivosClienteOut($prestamosResponse as element(ns2:OutputParameters),
    $PrestamoAdicResponse as element(*),
    $tarjetasCreditoResponse as element(ns0:TarjetasdecreditoporclienteResponse),
    $tarjetaCreditoAdicResponse as element(*))
    as element(ns1:consultaPasivosClienteResponse) {
        <ns1:consultaPasivosClienteResponse>
            <ns1:consultaPasivosClientePrestamosResponseType>
                {
                    for $ITEM at $i in $prestamosResponse/ns2:LIABILITY_NUMBER/ns2:ITEM
                    return
                        <ns1:consultaPasivosClienteResponseRecordType>
                            <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
                            <LIABILITY_NUMBER>{ data($ITEM) }</LIABILITY_NUMBER>
                            <LIABILITY_CUST_NAME>{ data($PrestamoAdicResponse/Prestamo[$i]/LOAN_CUSTOMER_NAME) }</LIABILITY_CUST_NAME>
                            <LIABILITY_CURRENCY_1>{ data($PrestamoAdicResponse/Prestamo[$i]/CURRENCY) }</LIABILITY_CURRENCY_1>
                            <LIABILITY_PRINCIPAL_AMT_1>{ data($PrestamoAdicResponse/Prestamo[$i]/PRINCIPAL_AMOUNT) }</LIABILITY_PRINCIPAL_AMT_1>
                            <LIABILITY_INT_COM_AMT_1>{ data($PrestamoAdicResponse/Prestamo[$i]/INTEREST_AND_COMISSION_AMOUNT) }</LIABILITY_INT_COM_AMT_1>
                            <LIABILITY_TOTAL_AMT_1>{ data($PrestamoAdicResponse/Prestamo[$i]/TOTAL_AMOUNT) }</LIABILITY_TOTAL_AMT_1>
                            <LIABILITY_TOTAL_AMT>{ data($PrestamoAdicResponse/Prestamo[$i]/TOTAL_AMOUNT) }</LIABILITY_TOTAL_AMT>
                        </ns1:consultaPasivosClienteResponseRecordType>
                }
            </ns1:consultaPasivosClientePrestamosResponseType>
            <ns1:consultaPasivosClienteTCreditoResponseType>
                {
                    for $mFICOLISTCLIENTCARDCPDetailType at $i in $tarjetasCreditoResponse/FICOLISTCLIENTCARDCPType[1]/gFICOLISTCLIENTCARDCPDetailType/mFICOLISTCLIENTCARDCPDetailType[STATUS!="29 - TARJETA DADA DE BAJA" and CATEGORY!="Additional"]
                    return
                        <ns1:consultaPasivosClienteResponseRecordType>
                            <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
                            <LIABILITY_NUMBER>{ data($mFICOLISTCLIENTCARDCPDetailType/CARDNO) }</LIABILITY_NUMBER>
                            <LIABILITY_CUST_NAME>{ data($mFICOLISTCLIENTCARDCPDetailType/CARDNAME) }</LIABILITY_CUST_NAME>
                            <LIABILITY_CURRENCY_1>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/LOCAL_CURRENCY) }</LIABILITY_CURRENCY_1>
                            <LIABILITY_PRINCIPAL_AMT_1>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/LOCAL_BALANCE) }</LIABILITY_PRINCIPAL_AMT_1>
                            <LIABILITY_TOTAL_AMT_1>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/LOCAL_BALANCE) }</LIABILITY_TOTAL_AMT_1>
                            <LIABILITY_CURRENCY_2>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/FOREIGN_CURRENCY) }</LIABILITY_CURRENCY_2>
                            <LIABILITY_PRINCIPAL_AMT_2>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/FOREIGN_BALANCE) }</LIABILITY_PRINCIPAL_AMT_2>
                            <LIABILITY_TOTAL_AMT_2>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/FOREIGN_BALANCE) }</LIABILITY_TOTAL_AMT_2>
                            <LIABILITY_TOTAL_AMT>{ data($tarjetaCreditoAdicResponse/Tarjeta[$i]/TOTAL_AMOUNT) }</LIABILITY_TOTAL_AMT>
                        </ns1:consultaPasivosClienteResponseRecordType>
                }
            </ns1:consultaPasivosClienteTCreditoResponseType>
        </ns1:consultaPasivosClienteResponse>
};

declare variable $prestamosResponse as element(ns2:OutputParameters) external;
declare variable $PrestamoAdicResponse as element(*) external;
declare variable $tarjetasCreditoResponse as element(ns0:TarjetasdecreditoporclienteResponse) external;
declare variable $tarjetaCreditoAdicResponse as element(*) external;

xf:consultaPasivosClienteOut($prestamosResponse,
    $PrestamoAdicResponse,
    $tarjetasCreditoResponse,
    $tarjetaCreditoAdicResponse)