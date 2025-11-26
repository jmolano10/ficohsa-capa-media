(:: pragma bea:global-element-parameter parameter="$guardarClienteRTE" element="ns0:guardarClienteRTE" location="../../xsds/GuardarClienteRTE/GuardarClienteRTE.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/GuardarClienteRTE/GuardarClienteRTE/FLINK_OSB_GUARDAR_CLIENTE_RTE.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/FLINK/OSB_GUARDAR_CLIENTE_RTE/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/guardarClienteRTETypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/GuardarClienteRTE/GuardarClienteRTEIn/";

declare function xf:GuardarClienteRTEIn($guardarClienteRTE as element(ns0:guardarClienteRTE))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:TIPO_ID>{ data($guardarClienteRTE/TYPE_ID) }</ns1:TIPO_ID>
            <ns1:NUMERO_ID>{ data($guardarClienteRTE/ID_NUMBER) }</ns1:NUMERO_ID>
            <ns1:NOMBRE_COMPLETO>{ data($guardarClienteRTE/FULL_NAME) }</ns1:NOMBRE_COMPLETO>
            <ns1:FECHA_NACIMIENTO>{ data($guardarClienteRTE/DATE_OF_BIRTH) }</ns1:FECHA_NACIMIENTO>
            <ns1:GENERO>{ data($guardarClienteRTE/GENDER) }</ns1:GENERO>
            <ns1:PAIS>{ data($guardarClienteRTE/COUNTRY) }</ns1:PAIS>
            <ns1:NACIONALIDAD>{ data($guardarClienteRTE/NATIONALITY) }</ns1:NACIONALIDAD>
            <ns1:DEPARTAMENTO>{ data($guardarClienteRTE/DEPARTMENT) }</ns1:DEPARTAMENTO>
            <ns1:MUNICIPIO>{ data($guardarClienteRTE/MUNICIPALITY) }</ns1:MUNICIPIO>
            <ns1:DIRECCION>{ data($guardarClienteRTE/ADDRESS) }</ns1:DIRECCION>
            <ns1:TELEFONO_DOMICILIO>{ data($guardarClienteRTE/RESIDENCE_PHONE) }</ns1:TELEFONO_DOMICILIO>
            <ns1:PROFESION>{ data($guardarClienteRTE/PROFESSION) }</ns1:PROFESION>
            {
                for $COMPANY_NAME in $guardarClienteRTE/COMPANY_NAME
                return
                    <ns1:LUGAR_TRABAJO>{ data($COMPANY_NAME) }</ns1:LUGAR_TRABAJO>
            }
            {
                for $WORK_PHONE in $guardarClienteRTE/WORK_PHONE
                return
                    <ns1:TELEFONO_TRABAJO>{ data($WORK_PHONE) }</ns1:TELEFONO_TRABAJO>
            }
            <ns1:ACTIVIDAD_ECONOMICA>{ data($guardarClienteRTE/ECONOMIC_ACT) }</ns1:ACTIVIDAD_ECONOMICA>
            {
                for $RELATION_WITH_BENEFICIARY in $guardarClienteRTE/RELATION_WITH_BENEFICIARY
                return
                    <ns1:RELACION_BENEFICIARIO>{ data($RELATION_WITH_BENEFICIARY) }</ns1:RELACION_BENEFICIARIO>
            }
        </ns1:InputParameters>
};

declare variable $guardarClienteRTE as element(ns0:guardarClienteRTE) external;

xf:GuardarClienteRTEIn($guardarClienteRTE)