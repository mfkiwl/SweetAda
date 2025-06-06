-----------------------------------------------------------------------------------------------------------------------
--                                                     SweetAda                                                      --
-----------------------------------------------------------------------------------------------------------------------
-- __HDS__                                                                                                           --
-- __FLN__ fatfs-cluster.ads                                                                                         --
-- __DSC__                                                                                                           --
-- __HSH__ e69de29bb2d1d6434b8b29ae775ad8c2e48c5391                                                                  --
-- __HDE__                                                                                                           --
-----------------------------------------------------------------------------------------------------------------------
-- Copyright (C) 2020-2025 Gabriele Galeotti                                                                         --
--                                                                                                                   --
-- SweetAda web page: http://sweetada.org                                                                            --
-- contact address: gabriele.galeotti@sweetada.org                                                                   --
-- This work is licensed under the terms of the MIT License.                                                         --
-- Please consult the LICENSE.txt file located in the top-level directory.                                           --
-----------------------------------------------------------------------------------------------------------------------

package FATFS.Cluster
   is

   --========================================================================--
   --                                                                        --
   --                                                                        --
   --                               Public part                              --
   --                                                                        --
   --                                                                        --
   --========================================================================--

   ----------------------------------------------------------------------------
   -- Is_End
   ----------------------------------------------------------------------------
   -- Return True if sector is at the end of a cluster.
   ----------------------------------------------------------------------------
   function Is_End
      (CCB : in CCB_Type)
      return Boolean
      with Inline => True;

   ----------------------------------------------------------------------------
   -- To_Sector
   ----------------------------------------------------------------------------
   -- Compute sector address of a cluster.
   ----------------------------------------------------------------------------
   function To_Sector
      (D : in Descriptor_Type;
       C : in Cluster_Type)
      return Sector_Type
      with Inline => True;

   ----------------------------------------------------------------------------
   -- File_EOF
   ----------------------------------------------------------------------------
   -- Return data cluster EOF value.
   ----------------------------------------------------------------------------
   function File_EOF
      (F : in FAT_Type)
      return Cluster_Type
      with Inline => True;

   ----------------------------------------------------------------------------
   -- Map
   ----------------------------------------------------------------------------
   -- Look for an arbitrary region of the filesystem as if it was a cluster.
   ----------------------------------------------------------------------------
   procedure Map
      (CCB   :    out CCB_Type;
       S     : in     Sector_Type;
       Count : in     Unsigned_16);

   ----------------------------------------------------------------------------
   -- Open
   ----------------------------------------------------------------------------
   -- Open a cluster.
   ----------------------------------------------------------------------------
   procedure Open
      (D          : in     Descriptor_Type;
       CCB        : in out CCB_Type;
       C          : in     Cluster_Type;
       Keep_First : in     Boolean);

   ----------------------------------------------------------------------------
   -- Advance
   ----------------------------------------------------------------------------
   -- Advance by one sector in a cluster.
   ----------------------------------------------------------------------------
   procedure Advance
      (D       : in     Descriptor_Type;
       CCB     : in out CCB_Type;
       B       : in out Block_Type;
       Success :    out Boolean);

   ----------------------------------------------------------------------------
   -- Peek
   ----------------------------------------------------------------------------
   -- Read a cluster, without sector bumping.
   ----------------------------------------------------------------------------
   procedure Peek
      (D       : in     Descriptor_Type;
       CCB     : in out CCB_Type;
       B       :    out Block_Type;
       Success :    out Boolean);

   ----------------------------------------------------------------------------
   -- Rewind
   ----------------------------------------------------------------------------
   -- Rewind the cluster chain.
   ----------------------------------------------------------------------------
   procedure Rewind
      (D   : in     Descriptor_Type;
       CCB : in out CCB_Type);

   ----------------------------------------------------------------------------
   -- Prelocate
   ----------------------------------------------------------------------------
   -- Pre-locate a free cluster.
   ----------------------------------------------------------------------------
   procedure Prelocate
      (D : in out Descriptor_Type;
       B :    out Block_Type);

   ----------------------------------------------------------------------------
   -- Get_First
   ----------------------------------------------------------------------------
   -- Get a 16/32-bit cluster # from directory entry.
   ----------------------------------------------------------------------------
   function Get_First
      (D  : in Descriptor_Type;
       DE : in Directory_Entry_Type)
      return Cluster_Type;

   ----------------------------------------------------------------------------
   -- Put_First
   ----------------------------------------------------------------------------
   -- Put a 16/32-bit cluster # into directory entry.
   ----------------------------------------------------------------------------
   procedure Put_First
      (D  : in     Descriptor_Type;
       DE : in out Directory_Entry_Type;
       C  : in     Cluster_Type);

   ----------------------------------------------------------------------------
   -- Claim
   ----------------------------------------------------------------------------
   -- Claim the cluster by marking it as last in cluster chain.
   ----------------------------------------------------------------------------
   procedure Claim
      (D       : in out Descriptor_Type;
       B       :    out Block_Type;
       C       : in     Cluster_Type;
       Chain   : in     Cluster_Type;
       Success :    out Boolean);

   ----------------------------------------------------------------------------
   -- Read
   ----------------------------------------------------------------------------
   -- Read cluster and advance by one sector.
   ----------------------------------------------------------------------------
   procedure Read
      (D       : in     Descriptor_Type;
       CCB     : in out CCB_Type;
       B       :    out Block_Type;
       Success :    out Boolean);

   ----------------------------------------------------------------------------
   -- Reread
   ----------------------------------------------------------------------------
   -- Re-read the last read sector of a cluster.
   ----------------------------------------------------------------------------
   procedure Reread
      (D       : in     Descriptor_Type;
       CCB     : in     CCB_Type;
       B       :    out Block_Type;
       Success :    out Boolean);

   ----------------------------------------------------------------------------
   -- Release_Chain
   ----------------------------------------------------------------------------
   -- Release a cluster chain.
   ----------------------------------------------------------------------------
   procedure Release_Chain
      (D             : in     Descriptor_Type;
       First_Cluster : in     Cluster_Type;
       B             :    out Block_Type);

   ----------------------------------------------------------------------------
   -- Write
   ----------------------------------------------------------------------------
   -- Write the next sector, get next/extend cluster and write.
   ----------------------------------------------------------------------------
   procedure Write
      (D       : in out Descriptor_Type;
       File    : in out WCB_Type;
       B       : in out Block_Type;
       Success :    out Boolean);

   ----------------------------------------------------------------------------
   -- Close
   ----------------------------------------------------------------------------
   -- Close a cluster.
   ----------------------------------------------------------------------------
   procedure Close
      (CCB : out CCB_Type);

end FATFS.Cluster;
