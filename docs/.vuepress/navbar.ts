import { navbar } from "vuepress-theme-hope";

export default navbar([
  // "/",
  // "/home",
  {
    text: "云原生",
    icon: "creative",
    prefix: "/cloud/",
    children: [
      {
        text: "kubeneter",
        children:[
          {
            text: "kubeneter入门",
            link: "kubernetes/base/01.k8s_models"
          },
          {
            text: "kubeneter进阶",
            link: "kubernetes/adv/"
          },
          {
            text: "kubeneter高级",
            link: ""
          },
          {
            text: "kubeneter问题记录",
            link: ""
          }
        ]
      },
      {
        text: "ceph",
        children:[
          {
            text: "ceph原理篇",
            link: "ceph/principle"
          },
          {
            text: "ceph实战篇",
            link: "ceph/actual/01.deploy-Ceph-based-on -ceph-deploy"
          },
          {
            text: "ceph问题记录",
            link: ""
          }
        ]
      },
      {
        text: "docker",
        children:[
          {
            text: "docker基础",
            link: "docker/base/"
          },
          {
            text: "docker基础",
            link: "docker/adv/"
          }
        ]
      }
    ]
  },
  


]);
