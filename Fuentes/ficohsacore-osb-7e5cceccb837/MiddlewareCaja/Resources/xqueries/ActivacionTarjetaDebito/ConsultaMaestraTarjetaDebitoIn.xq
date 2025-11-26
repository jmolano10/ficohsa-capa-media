(:: pragma bea:global-element-parameter parameter="$activaciondetarjetadedebito" element="ns0:Activaciondetarjetadedebito" location="../../xsds/ActivacionTarjetaDebito/ActivacionTarjetaDebito.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../../xsds/TarjetaDebito/XMLSchema_-155258746.xsd" ::)

declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ActivacionTarjetaDebito/ConsultaMaestraTarjetaDebitoIn/";

declare function xf:ConsultaMaestraTarjetaDebitoIn($activaciondetarjetadedebito as element(ns0:Activaciondetarjetadedebito))
    as element(ns0:ConsultaMaestraTarjetaDebito) {
        <ns0:ConsultaMaestraTarjetaDebito>
            {
                for $WebRequestCommon in $activaciondetarjetadedebito/WebRequestCommon
                return
                    <WebRequestCommon>{ $WebRequestCommon/@* , $WebRequestCommon/node() }</WebRequestCommon>
            }
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat("...", xs:long($activaciondetarjetadedebito/LATAMCARDORDERACTIVEType/@id)) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $activaciondetarjetadedebito as element(ns0:Activaciondetarjetadedebito) external;

xf:ConsultaMaestraTarjetaDebitoIn($activaciondetarjetadedebito)