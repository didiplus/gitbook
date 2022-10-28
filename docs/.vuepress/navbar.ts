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
            link: ""
          },
          {
            text: "kubeneter进阶",
            link: ""
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
            link: "ceph/principle/01.test"
          },
          {
            text: "ceph实战篇",
            link: "ceph/actual/01.test"
          },
          {
            text: "ceph问题记录",
            link: ""
          }
        ]
      }
    ]
  },
  


]);
