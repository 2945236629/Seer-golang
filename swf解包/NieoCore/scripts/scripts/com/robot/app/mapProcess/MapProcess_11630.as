package com.robot.app.mapProcess
{
   import com.robot.app.fight.FightManager;
   import com.robot.app.task.petstory.util.KTool;
   import com.robot.app.toolBar.ToolBarController;
   import com.robot.core.BitBuffSetClass;
   import com.robot.core.animate.AnimateManager;
   import com.robot.core.manager.LevelManager;
   import com.robot.core.manager.MapManager;
   import com.robot.core.manager.ModuleManager;
   import com.robot.core.manager.PetManager;
   import com.robot.core.manager.map.config.BaseMapProcess;
   import com.robot.core.npc.NpcDialogNew_1;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcess_11630 extends BaseMapProcess
   {
      
      private var state:int;
      
      private var bossState:int;
      
      public function MapProcess_11630()
      {
         super();
      }
      
      override protected function init() : void
      {
         LevelManager.iconLevel.visible = false;
         ToolBarController.panel.visible = false;
         LevelManager.toolsLevel.visible = false;
         KTool.getMultiValue([101458,101459],function(param1:Array):void
         {
            state = param1[0];
            bossState = param1[1];
            conLevel.addEventListener(MouseEvent.CLICK,onConClick);
            playStory();
         });
      }
      
      public function onConClick(param1:MouseEvent) : void
      {
         var index:int = 0;
         var e:MouseEvent = param1;
         index = int(e.target.name.split("_")[1]);
         switch(e.target.name)
         {
            case "fight":
               index = int(e.target.parent.name.split("_")[1]);
               BitBuffSetClass.setState(23585 + index,1,function():void
               {
                  FightManager.fightNoMapBoss("",12336 + index,false,true,function():void
                  {
                     BitBuffSetClass.setState(23585 + index,0,function():void
                     {
                        MapManager.refMap(false,true);
                     });
                  });
               });
               break;
            case "close":
               this.destroy();
               KTool.changeMapWithCallBack(1,function():void
               {
                  ModuleManager.showAppModule("PlantsAssistanceMainPanel");
               });
               break;
            case "bag":
               ModuleManager.showAppModule("ADPetBagPanelNew");
               break;
            case "cure":
               PetManager.cureAllFree();
         }
      }
      
      public function playStory() : void
      {
         if(this.state == 2)
         {
            conLevel["mc"].gotoAndStop(4);
            conLevel.mouseEnabled = conLevel.mouseChildren = false;
            NpcDialogNew_1.show(11,["怎么样？探查的如何了？"],null,null,false,function():void
            {
               NpcDialogNew_1.show(20,["的确如纳纳所说，当泰图被击杀时，会有很多恶心的小虫子从它的体内钻出来。"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(2872,["我们需要有诚意的结盟，贾斯汀。我是绝对不会欺骗你们的。"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(11,["脑虫真的太可怕了，我们必须保护我们的精灵朋友们。"],null,null,false,function():void
                     {
                        NpcDialogNew_1.show(2858,["站长，她打伤了我的朋友，难道我们还要和她结盟？这些天那些被植物击伤的战友们会怎么想？"],null,null,false,function():void
                        {
                           NpcDialogNew_1.show(11,["唔……"],null,null,false,function():void
                           {
                              NpcDialogNew_1.show(2872,["在这点上你们不用多虑，朋友们。我们对前些日子的莽撞行为深表歉意，我此次来到这里，也是为了表示一些心意。"],null,null,false,function():void
                              {
                                 NpcDialogNew_1.show(2858,["我只希望我的朋友可以恢复过来！"],["这当然没有问题"],[function():void
                                 {
                                    NpcDialogNew_1.show(2872,["我们为大家准备了许多神奇的水果，可以让这些日子被误伤的朋友立刻恢复活力。"],null,null,false,function():void
                                    {
                                       NpcDialogNew_1.show(2872,["我代表植物一族真心地希望大家考虑一下结盟的事情。毕竟多一个朋友，少一个敌人，这可以帮助我们反抗虫族的统治！"],null,null,false,function():void
                                       {
                                          NpcDialogNew_1.show(11,["我想你已经表现出了足够的善意。从当前的处境来看，与你们结盟的确是最好的选择。"],null,null,false,function():void
                                          {
                                             NpcDialogNew_1.show(11,["但我们必须说明一件事情。我们本不是这个星球上的居民，也无意搅入你们的势力斗争，我们结盟只是为了让我们能够在这里存活下去。"],null,null,false,function():void
                                             {
                                                NpcDialogNew_1.show(11,["我们可以保证不进行扩张和战争，但是当我们准备离开这个星球时，我希望你们不要为难我们。"],null,null,false,function():void
                                                {
                                                   NpcDialogNew_1.show(2872,["这是正常的请求，我可以直接代替全族表示同意。"],null,null,false,function():void
                                                   {
                                                      NpcDialogNew_1.show(11,["那真是太好了！希望你能在此小住几日，容我们准备一下，便可以与你们正式结盟了！"],["谢谢你们，虫族必败！"],[function():void
                                                      {
                                                         conLevel.mouseEnabled = conLevel.mouseChildren = true;
                                                         KTool.changeMapWithCallBack(1,function():void
                                                         {
                                                            ModuleManager.showAppModule("PlantsAssistanceMainPanel");
                                                         });
                                                      }]);
                                                   });
                                                });
                                             });
                                          });
                                       });
                                    });
                                 }]);
                              });
                           });
                        });
                     });
                  });
               });
            });
         }
         else if(this.bossState == 7 && Boolean(BitBuffSetClass.getState(23586)) && Boolean(BitBuffSetClass.getState(23587)) && Boolean(BitBuffSetClass.getState(23588)))
         {
            ModuleManager.showAppModule("PlantsAssistanceMainPanel",3);
         }
         else if(BitBuffSetClass.getState(23584))
         {
            MovieClip(conLevel["mc"]).addEventListener(Event.FRAME_CONSTRUCTED,function(param1:Event):void
            {
               var i:int;
               var e:Event = param1;
               MovieClip(e.currentTarget).removeEventListener(Event.FRAME_CONSTRUCTED,arguments.callee);
               i = 1;
               while(i <= 3)
               {
                  if(KTool.getBit(bossState,i) == 1 && BitBuffSetClass.getState(23585 + i) == 0)
                  {
                     AnimateManager.playMcAnimate(conLevel["mc"],3,"mc_" + i,function():void
                     {
                        playStory();
                     });
                     BitBuffSetClass.setState(23585 + i,1);
                  }
                  else if(KTool.getBit(bossState,i) == 1)
                  {
                     conLevel["mc"]["mc_" + i].visible = false;
                  }
                  else
                  {
                     conLevel["mc"]["mc_" + i].visible = true;
                  }
                  i++;
               }
            });
            conLevel["mc"].gotoAndStop(3);
         }
         else
         {
            conLevel["mc"].gotoAndStop(1);
            conLevel.mouseEnabled = conLevel.mouseChildren = false;
            NpcDialogNew_1.show(2872,["虫族之所以能够控制星球上这么多生物，是因为他们使用了一种让人防不胜防的控制方式——脑虫。"],null,null,false,function():void
            {
               NpcDialogNew_1.show(11,["脑虫？这是什么？"],null,null,false,function():void
               {
                  NpcDialogNew_1.show(2872,["脑虫是一种寄生虫，它们由虫族细心培育，以母体为食。脑虫在虫族的安排下，进入水源或是“诱饵”，以保证能被动物们吃掉。"],null,null,false,function():void
                  {
                     NpcDialogNew_1.show(2872,["当脑虫进入宿主体内，它们会逐渐钻入宿主大脑，从而控制宿主思想，成为虫族的傀儡。"],null,null,false,function():void
                     {
                        AnimateManager.playMcAnimate(conLevel["mc"],2,"mc",function():void
                        {
                           NpcDialogNew_1.show(11,["这可太恐怖了，这么小的虫子，我们根本没有办法抵御！"],null,null,false,function():void
                           {
                              NpcDialogNew_1.show(2872,["是的，这也是仅有我们植物能够幸存的原因——脑虫只能控制动物和虫类，却对我们植物没有效果。"],null,null,false,function():void
                              {
                                 NpcDialogNew_1.show(336,["如果这是真的，那我们整个营地里的精灵们都正处于极为危险的境地，贾斯汀。"],null,null,false,function():void
                                 {
                                    NpcDialogNew_1.show(11,["没错，如果这是真的话。那么纳纳，我该如何相信你所说的“脑虫”呢？"],null,null,false,function():void
                                    {
                                       NpcDialogNew_1.show(2872,["这个容易。脑虫会在宿主体内繁殖出较大的规模，而宿主死亡时，它们会离开宿主体内，这时是可以观察到的。"],null,null,false,function():void
                                       {
                                          NpcDialogNew_1.show(2872,["你们去击杀几只向你们发起进攻的泰图，就能知道我是不是在骗你们了！"],["好，我们立刻行动！"],[function():void
                                          {
                                             conLevel.mouseEnabled = conLevel.mouseChildren = true;
                                             BitBuffSetClass.setState(23584,1,function():void
                                             {
                                                ModuleManager.showAppModule("PlantsAssistanceMainPanel",2);
                                                playStory();
                                             });
                                          }]);
                                       });
                                    });
                                 });
                              });
                           });
                        });
                     });
                  });
               });
            });
         }
      }
      
      override public function destroy() : void
      {
         LevelManager.iconLevel.visible = true;
         ToolBarController.panel.visible = true;
         LevelManager.toolsLevel.visible = true;
         if(conLevel != null)
         {
            conLevel.removeEventListener(MouseEvent.CLICK,this.onConClick);
         }
         super.destroy();
      }
   }
}

