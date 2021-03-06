PACKAGECONFIG_append = " networkd resolved"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_ni-sulfur-mender = " \
                                  file://eth0.network \
                                  file://sfp0.network \
                                  file://sfp1.network \
                                  "


FILES_${PN}_append_ni-sulfur-mender = " \
    ${sysconfdir}/systemd/network/eth0.network \
    ${sysconfdir}/systemd/network/sfp0.network \
    ${sysconfdir}/systemd/network/sfp1.network \
"

FILES_${PN}_append_ni-sulfur-mender = " \
    /data/* \
"

do_install_append_ni-sulfur-mender() {
    if ${@bb.utils.contains('PACKAGECONFIG','networkd','true','false',d)}; then

        install -d ${D}/data/network
        install -m 0755 ${WORKDIR}/eth0.network ${D}/data/network/eth0.network
        install -m 0755 ${WORKDIR}/sfp0.network ${D}/data/network/sfp0.network
        install -m 0755 ${WORKDIR}/sfp1.network ${D}/data/network/sfp1.network

        install -d ${D}${sysconfdir}/systemd/network
        ln -sf /data/network/eth0.network ${D}${sysconfdir}/systemd/network/eth0.network
        ln -sf /data/network/sfp0.network ${D}${sysconfdir}/systemd/network/sfp0.network
        ln -sf /data/network/sfp1.network ${D}${sysconfdir}/systemd/network/sfp1.network

        if [ -e ${D}${sysconfdir}/systemd/network/eth.network ]; then
            rm ${D}${sysconfdir}/systemd/network/eth.network
        fi
    fi
}
