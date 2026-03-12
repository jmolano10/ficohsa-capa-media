xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMaestraTarjetaDebitoResponse1" element="ns0:ConsultaMaestraTarjetaDebitoResponse" location="../Resources/XMLSchema_-155258746.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaTDCliente/consultaTDClienteHeaderOutZero/";

declare function xf:consultaTDClienteHeaderOutZero($consultaMaestraTarjetaDebitoResponse1 as element(ns0:ConsultaMaestraTarjetaDebitoResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            <successIndicator>NO RECORD</successIndicator>
            {
                for $ZERORECORDS in $consultaMaestraTarjetaDebitoResponse1/WSFICODEBITCARDCUSTOMERType[1]/ZERORECORDS
                return
                    <messages>{ data($ZERORECORDS) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultaMaestraTarjetaDebitoResponse1 as element(ns0:ConsultaMaestraTarjetaDebitoResponse) external;

xf:consultaTDClienteHeaderOutZero($consultaMaestraTarjetaDebitoResponse1)