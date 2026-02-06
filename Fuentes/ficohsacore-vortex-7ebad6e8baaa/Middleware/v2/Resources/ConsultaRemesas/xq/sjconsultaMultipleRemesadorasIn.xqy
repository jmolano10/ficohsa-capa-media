xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns3:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaRemesas" element="ns0:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns2:OutputParameters" location="../../../BusinessServices/MDW/obtenerTipoRemesadora/xsd/ObtenerTipoRemesadora_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns1:sjConsultaMultipleRemesadoras" location="../../../BusinessServices/SJS/consultaMultipleRemesadoras/xsd/sjConsultaMultipleRemesadoras.xsd" ::)

declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadoras";
declare namespace ns3 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/sjconsultaMultipleRemesadorasIn/";

declare function xf:sjconsultaMultipleRemesadorasIn($requestHeader as element(ns3:RequestHeader),
    $consultaRemesas as element(ns0:consultaRemesas),
    $outputParameters as element(ns2:OutputParameters))
    as element(ns1:sjConsultaMultipleRemesadoras) {
        <ns1:sjConsultaMultipleRemesadoras>
            <ns1:USERNAME>{ data($requestHeader/Authentication/UserName) }</ns1:USERNAME>
            {
                for $REMITTANCE_ID in $consultaRemesas/REMITTANCE_ID
                return
                    <ns1:REMITTANCE_ID>{ data($REMITTANCE_ID) }</ns1:REMITTANCE_ID>
            }
            {
                for $CORRESPONSAL_BRANCHCODE in $consultaRemesas/CORRESPONSAL_BRANCHCODE
                return
                    <ns1:CORRESPONSAL_BRANCHCODE>{ data($CORRESPONSAL_BRANCHCODE) }</ns1:CORRESPONSAL_BRANCHCODE>
            }
            {
                for $BENEFICIARY_FIRSTNAME in $consultaRemesas/BENEFICIARY_FIRSTNAME
                return
                    <ns1:BENEFICIARY_FIRSTNAME>{ data($BENEFICIARY_FIRSTNAME) }</ns1:BENEFICIARY_FIRSTNAME>
            }
            {
                for $BENEFICIARY_MIDDLENAME in $consultaRemesas/BENEFICIARY_MIDDLENAME
                return
                    <ns1:BENEFICIARY_MIDDLENAME>{ data($BENEFICIARY_MIDDLENAME) }</ns1:BENEFICIARY_MIDDLENAME>
            }
            {
                for $BENEFICIARY_FIRSTSURNAME in $consultaRemesas/BENEFICIARY_FIRSTSURNAME
                return
                    <ns1:BENEFICIARY_FIRSTSURNAME>{ data($BENEFICIARY_FIRSTSURNAME) }</ns1:BENEFICIARY_FIRSTSURNAME>
            }
            {
                for $BENEFICIARY_SECONDSURNAME in $consultaRemesas/BENEFICIARY_SECONDSURNAME
                return
                    <ns1:BENEFICIARY_SECONDSURNAME>{ data($BENEFICIARY_SECONDSURNAME) }</ns1:BENEFICIARY_SECONDSURNAME>
            }
            {
                for $PT_TIPOS_REMESADORAS in $outputParameters/ns2:PT_TIPOS_REMESADORAS
                return
                    <ns1:TYPES_REMITTANCE>
                        {
                            for $PT_TIPOS_REMESADORAS_ITEM in $PT_TIPOS_REMESADORAS/ns2:PT_TIPOS_REMESADORAS_ITEM
                            return
                                <ns1:TYPES_REMITTANCE_ITEM>
                                    {
                                        for $PV_NOMBRE_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_NOMBRE_REMESADORA
                                        return
                                            <ns1:NAME_REMITTANCE>{ data($PV_NOMBRE_REMESADORA) }</ns1:NAME_REMITTANCE>
                                    }
                                    {
                                        for $PV_TIPO_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_TIPO_REMESADORA
                                        return
                                            <ns1:TYPE_REMITTANCE>{ data($PV_TIPO_REMESADORA) }</ns1:TYPE_REMITTANCE>
                                    }
                                    {
                                        for $PN_ID_CONVENIO in $PT_TIPOS_REMESADORAS_ITEM/ns2:PN_ID_CONVENIO
                                        return
                                            <ns1:AGREEMENT_ID>{ data($PN_ID_CONVENIO) }</ns1:AGREEMENT_ID>
                                    }
                                    {
                                        for $PV_ID_CONVENIO_T24 in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_ID_CONVENIO_T24
                                        return
                                            <ns1:AGREEMENT_ID_T24>{ data($PV_ID_CONVENIO_T24) }</ns1:AGREEMENT_ID_T24>
                                    }
                                    {
                                        for $PV_ABREVIATURA_REMESADORA in $PT_TIPOS_REMESADORAS_ITEM/ns2:PV_ABREVIATURA_REMESADORA
                                        return
                                            <ns1:ABBREVIATION_REMITTANCE>{ data($PV_ABREVIATURA_REMESADORA) }</ns1:ABBREVIATION_REMITTANCE>
                                    }
                                    {
                                        for $PN_PRIORIDAD in $PT_TIPOS_REMESADORAS_ITEM/ns2:PN_PRIORIDAD
                                        return
                                            <ns1:PRIORITY>{ data($PN_PRIORIDAD) }</ns1:PRIORITY>
                                    }
                                </ns1:TYPES_REMITTANCE_ITEM>
                        }
                    </ns1:TYPES_REMITTANCE>
            }
            {
                for $ADDITIONAL_INFO in $consultaRemesas/ADDITIONAL_INFO
                return
                    <ns1:ADDITIONAL_INFO>
                        {
                            for $INFO in $ADDITIONAL_INFO/INFO
                            return
                                <ns1:INFO>
                                    {
                                        for $NAME in $INFO/NAME
                                        return
                                            <ns1:NAME>{ data($NAME) }</ns1:NAME>
                                    }
                                    {
                                        for $VALUE in $INFO/VALUE
                                        return
                                            <ns1:VALUE>{ data($VALUE) }</ns1:VALUE>
                                    }
                                </ns1:INFO>
                        }
                    </ns1:ADDITIONAL_INFO>
            }
        </ns1:sjConsultaMultipleRemesadoras>
};

declare variable $requestHeader as element(ns3:RequestHeader) external;
declare variable $consultaRemesas as element(ns0:consultaRemesas) external;
declare variable $outputParameters as element(ns2:OutputParameters) external;

xf:sjconsultaMultipleRemesadorasIn($requestHeader,
    $consultaRemesas,
    $outputParameters)