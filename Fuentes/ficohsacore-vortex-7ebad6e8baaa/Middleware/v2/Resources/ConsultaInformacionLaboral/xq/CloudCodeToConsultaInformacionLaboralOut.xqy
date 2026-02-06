xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes";
(:: import schema at "../xsd/consultaInformacionLaboralTypes.xsd" ::)
declare namespace ns1="https://www.ficohsa.com/honduras/pension/cloudCodeTypes";
(:: import schema at "../../../BusinessServices/FPC/CloudCode/Schemas/CloudCodeTypes.xsd" ::)

declare variable $response as element() (:: schema-element(ns1:clientesHistoricasLaboralesResponse) ::) external;

declare function local:func($response as element() (:: schema-element(ns1:clientesHistoricasLaboralesResponse) ::)) as element() (:: schema-element(ns2:consultaInformacionLaboralResponse) ::) {
    <ns2:consultaInformacionLaboralResponse>
        <ns2:JOB_INFO_HISTORY>
           {
                for $item in $response/ns1:datos/ns1:laborales/ns1:infoLaboralHistorica
                return 
                <ns2:JOB_INFO_HISTORY_ITEM>
                    <ns2:CUSTOMER_ACCOUNT>{ data($item/ns1:codigoCuenta) }</ns2:CUSTOMER_ACCOUNT>
                    <ns2:STATUS>{data($item/ns1:estadoCuenta)}</ns2:STATUS>
                    <ns2:START_DATE/>
                    {
                     element ns2:END_DATE{ data($item/ns1:fechaFin) }
                    }
                    <ns2:PAYMENT_PERIOD>{ data($item/ns1:periodo) }</ns2:PAYMENT_PERIOD>
                    <ns2:EMPLOYER_CODE>{ data($item/ns1:codigoEmpleador) }</ns2:EMPLOYER_CODE>
                    <ns2:EMPLOYER_NAME>{ data($item/ns1:nombreEmpleador) }</ns2:EMPLOYER_NAME>
                    <ns2:EMPLOYER_RTN>{ data($item/ns1:RTNEmpleador) }</ns2:EMPLOYER_RTN>
                    <ns2:BALANCE_TYPE>{ data($item/ns1:tipoIngreso) }</ns2:BALANCE_TYPE>
                    <ns2:PAYMENT_AMOUNT>{ data($item/ns1:montoAporte) }</ns2:PAYMENT_AMOUNT>
                    <ns2:SALARY_CURRENCY/>
                    <ns2:SALARY_AMOUNT>{ data($item/ns1:montoSalario) }</ns2:SALARY_AMOUNT>
                    <ns2:OCCUPATION_CODE/>
                    <ns2:OCCUPATION_DESC>{ data($item/ns1:descripcionOcupacion) }</ns2:OCCUPATION_DESC>
                    <ns2:JOB_TITLE_CODE/>
                    <ns2:JOB_TITLE_DESC>{ data($item/ns1:descripcionTrabajo) }</ns2:JOB_TITLE_DESC>
                </ns2:JOB_INFO_HISTORY_ITEM>
           }
            </ns2:JOB_INFO_HISTORY>
    </ns2:consultaInformacionLaboralResponse>
};

local:func($response)