PACKAGECONFIG_append = " networkd resolved"

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append_ni-e31x-mender = " \
                                  file://eth0.network \
                                  "

FILES_${PN}_append_ni-e31x-mender = " \
    ${sysconfdir}/systemd/network/eth0.network \
"

FILES_${PN}_append_ni-e31x-mender = " \
    /data/* \
"

do_install_append_ni-e31x-mender() {
  if ${@bb.utils.contains('PACKAGECONFIG','networkd','true','false',d)}; then
        install -d ${D}${sysconfdir}/systemd/network
        install -d ${D}/data/network

        install -m 0755 ${WORKDIR}/eth0.network ${D}/data/network
        ln -sf /data/network/eth0.network ${D}${sysconfdir}/systemd/network/eth0.network

        if [ -e ${D}${sysconfdir}/systemd/network/eth.network ]; then
            rm ${D}${sysconfdir}/systemd/network/eth.network
        fi
  fi
}
